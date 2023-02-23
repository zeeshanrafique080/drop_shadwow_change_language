import 'dart:io';
import 'dart:typed_data';

import 'package:drop_shadow_for_instagram/my_creations.dart';
import 'package:drop_shadow_for_instagram/setting_page_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  final ImagePicker imgpicker = ImagePicker();
  late File imagefiles;
  String imagepath = "";

  //Local language String
  final List locale = [
    {'name': 'ENGLISH', 'Locale': const Locale('en', 'US')},
    {'name': 'हिंदी', 'Locale': const Locale('hi', 'IN')},
    {'name': 'اردو', 'Locale': const Locale('ur', 'UR')},
  ];

//update language
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  //show diloage
  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (Builder) {
          return AlertDialog(
            title: const Text("Choose Language"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            updateLanguage(locale[index]['Locale']);
                          },
                          child: Text(locale[index]['name'])),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  urllaunch() async {
    const url = "https://www.instagram.com/";
    var convert = Uri.parse(url);
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launchUrl(convert);
    } else {
      throw "could not launch Url";
    }
  }

  openImage() async {
    try {
      // ignore: deprecated_member_use
      var pickedFile = await imgpicker.getImage(
          source: ImageSource.gallery, maxWidth: 300, maxHeight: 300);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imagefiles = File(imagepath);
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  //crop image
  cropImage() async {
    CroppedFile? croppedfile = await ImageCropper()
        .cropImage(sourcePath: imagepath, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          toolbarColor: Colors.deepPurpleAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    ]);

    if (croppedfile != null) {
      imagefiles = croppedfile as File;
      setState(() {
        Container(
          height: 200,
          width: 200,
        );
      });
    } else {
      print("Image is not cropped.");
    }
  }

  Future<bool> showexitDiloge() async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Exit App"),
              content: Text("Do you went to exit this app"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("No")),
                //
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Yes")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image_Editor"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(MdiIcons.languageC),
            tooltip: 'Language',
            onPressed: () {
              builddialog(context);
            },
          ), //IconButton
          IconButton(
            icon: const Icon(MdiIcons.instagram),
            tooltip: 'Instagram',
            onPressed: () {
              urllaunch();
            },
          ),
          //
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Setting Icon',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settings_Page()));
            },
          ),
          //IconButton
        ], //<Widget>[]
      ),
      body: WillPopScope(
        onWillPop: showexitDiloge,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[300],
          child: Column(children: [
            imagepath != ""
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.file(
                        imagefiles,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    height: 300,
                    width: 300,
                    child: Image.asset("assets/sh.jpg"),
                  ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        openImage();
                      },
                      child: Text('Choose'.tr)),

                  //crop button --------------------
                  imagepath != ""
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            cropImage();
                          },
                          child: Text('Crop Image'.tr))
                      : Container(),

                  //save button -------------------
                  imagepath != ""
                      ? ElevatedButton(
                          onPressed: () async {
                            Uint8List bytes = await imagefiles.readAsBytes();
                            var result = await ImageGallerySaver.saveImage(
                                bytes,
                                quality: 60,
                                name: "new_mage.jpg");

                            if (result["isSuccess"] == true) {
                              print("Image saved successfully.");
                            } else {
                              print(result["errorMessage"]);
                            }
                          },
                          child: Text("Save Image".tr))
                      : Container(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => My_Creations()));
                      },
                      child: Text('My Creation'.tr))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

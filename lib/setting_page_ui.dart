// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({Key? key}) : super(key: key);

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  //list
  final List locale = [
    {'name': 'ENGLISH', 'Locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'Locale': Locale('hi', 'IN')},
    {'name': 'اردو', 'Locale': Locale('ur', 'UR')},
  ];
  //update
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

// diloge box for language
  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (Builder) {
          return AlertDialog(
            title: Text("Choose Language"),
            content: Container(
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
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  // url aluncher
  urllaunch() async {
    const url = "https://play.google.com/store/apps";
    var convert = Uri.parse(url);
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launchUrl(convert);
    } else {
      throw "could not launch Url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        title: Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "General ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 29,
              ),

              ListTile(
                onTap: () {
                  builddialog(context);
                },
                leading: Icon(Icons.language),
                title: Text("Language".tr),
                subtitle: Text("Other Language".tr),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.star),
                title: Text("Rate Us".tr),
                subtitle: Text("Rate us on share Review"),
              ),
              SizedBox(
                height: 10,
              ),
              //
              ListTile(
                hoverColor: Colors.blue,
                onTap: () {
                  urllaunch();
                },
                leading: Icon(Icons.more),
                title: Text("More apps".tr),
                subtitle: Text("Other Language"),
              ),

              //
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Share.share("com.example.drop_shadow_for_instagram");
                },
                leading: Icon(Icons.share),
                title: Text("Share Us".tr),
                subtitle: Text("Share this with friends and family"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:drop_shadow_for_instagram/Home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  int splashtime = 3;
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(
          //pushReplacement = replacing the route so that
          //splash screen won't show on back button press
          //navigation to Home page.
          builder: (context) {
        return Home_page();
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                //vertically align center
                children: <Widget>[
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/sh.jpg")),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    //margin top 30
                    child: const Text(
                      "Shadow_for_Instagram",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: const Text("Version: 1.0.0",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.purple,
                  )
                ])));
  }
}

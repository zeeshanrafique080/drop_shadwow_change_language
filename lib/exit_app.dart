// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Exit_App extends StatefulWidget {
  const Exit_App({Key? key}) : super(key: key);

  @override
  State<Exit_App> createState() => _Exit_AppState();
}

class _Exit_AppState extends State<Exit_App> {
  Future exitapps() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text("Do you went to exit from this app"),
              actions: [
                FlatButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text("Exit")),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Cancel")),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exitapps();

        return Future.value(false);
      },
      child: Scaffold(
        body: FlatButton(
          onPressed: () {
            exitapps();
          },
          child: Text("exit"),
        ),
      ),
    );
  }
}

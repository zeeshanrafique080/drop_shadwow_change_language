import 'package:flutter/material.dart';

class My_Creations extends StatefulWidget {
  const My_Creations({Key? key}) : super(key: key);

  @override
  State<My_Creations> createState() => _My_CreationsState();
}

class _My_CreationsState extends State<My_Creations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
        //replace with our own icon data.
      )),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: const [
            SizedBox(
              height: 60,
            ),
            Center(child: Text("No Photo Found"))
          ],
        ),
      ),
    );
  }
}

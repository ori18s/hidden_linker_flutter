import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:hidden_linker_flutter/screens/Home.dart';
import 'dart:developer' as developer;


class EditLinkPage extends StatefulWidget {
  static const routeName = '/editLink';

  final String title;
  final String description;
  final String url;

  const EditLinkPage({
    Key key,
    this.title,
    this.description,
    this.url
  }) : super(key: key);
  @override
  _EditLinkState createState() => _EditLinkState();
}

class _EditLinkState extends State<EditLinkPage> {


  final titleController = TextEditingController();
  final desController = TextEditingController();
  final urlController = TextEditingController();

  // initState() {
  //   super.initState();
  //   _init();
  // }

  // void _init () {
  //   dynamic args = ModalRoute.of(context).settings.arguments;
  //   titleController.text = args.title;  
  //   // developer.log('log me', name: 'my.app.category');
  //   // print('test $title');
  // }
  

  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context).settings.arguments;
    print('args $args');
    // titleController.text = args.title;  
    // return Scaffold(
    //   body: Center(
    //     child: Text("1234"),
    //   ),
    // );
    // dynamic args = ModalRoute.of(context).settings.arguments;
    // titleController.text = args.title;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Link"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
                controller: titleController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Name Here'),
              )
            ),

            Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
                // controller: studentClass,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Class Here'),
              )
            ),

            Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
                // controller: phoneNumber,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Phone Number Here'),
              )
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 20),
              ),
            ),

          ],
        ),
      )
    );
  }
}
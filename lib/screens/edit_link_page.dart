import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_linker_flutter/screens/Home.dart';
import 'dart:developer' as developer;

class EditLinkPage extends StatefulWidget {
  static const routeName = '/editLink';

  // final String title;
  // final String description;
  // final String url;

  // const EditLinkPage({
  //   Key key,
  //   this.title,
  //   this.description,
  //   this.url
  // }) : super(key: key);

  @override
  _EditLinkState createState() => _EditLinkState();
}

class _EditLinkState extends State<EditLinkPage> {
  var linkId;

  final titleController = TextEditingController();
  final urlController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context).settings.arguments as Map<String, String>;
      titleController.text = args["title"];
      urlController.text = args["url"];
      desController.text = args["description"];
      linkId = args["linkId"];
    });
  }
  

  Widget build(BuildContext context) {
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
                decoration: InputDecoration(hintText: 'Enter Title'),
              )
            ),

            Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
                controller: urlController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter URL'),
              )
            ),

            Container(
            width: 280,
            padding: EdgeInsets.all(10.0),
            child: TextField(
                controller: desController,
                autocorrect: true,
                decoration: InputDecoration(hintText: 'Enter Description'),
              )
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    "title": titleController.text,
                    "url": urlController.text,
                    "description": desController.text,
                    "linkId": linkId,
                  }
                );
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
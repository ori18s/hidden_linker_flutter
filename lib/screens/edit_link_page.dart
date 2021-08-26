import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';
import 'package:hidden_linker_flutter/screens/Home.dart';
  
class EditLinkPage extends StatelessWidget {
const EditLinkPage({key, this.arguments}) : super(key: key);

final ScreenArguments arguments;


  // static const routeName = '/extractArguments';


  @override
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
                // controller: name,
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
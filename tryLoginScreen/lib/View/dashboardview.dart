import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
        ),
        body: new Center(
            child: RaisedButton(
          onPressed: () {
             Navigator.pop(context);
          }, //code this later
          child: Text('Press here'),
        )));
  }
}
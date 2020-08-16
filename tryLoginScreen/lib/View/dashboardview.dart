import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import './mapview.dart';

class SecondPage extends StatelessWidget {
//    UserModel usermodel=UserModel();
String LEmail;
  SecondPage(this.LEmail);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
        ),
        body: new Column(
            children:<Widget>[
              Text(LEmail),
              RaisedButton(
          onPressed: () {
             Navigator.pop(context);
          }, //code this later
          child: Text('Press here'),
        ),
        RaisedButton(
          child: Center(
          child: Text("Map"),),
          onPressed: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(
                builder: (context) =>HomePage1()
            )
           );                              
          }),
          ]
        )
  
    );
  }
}
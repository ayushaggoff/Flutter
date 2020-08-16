import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../locator.dart';
import '../model/user_model.dart';
import '../view_controller/user_controller.dart';
import '../View/profile/avatar.dart';
import '../View/profile/manage_profile_information_widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget
{
    static String route = "profile-view";

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserModel _currentUser = locator.get<UserController>().currentUser;

 Widget build(BuildContext context) {
   print('iiiiiiiiiiinssssssssssssssiiiiiiiideeeeeeeee profileview:'+_currentUser.displayName.toString());
   print('iiiiiiiiiiinssssssssssssssiiiiiiiideeeeeeeee profileview:'+_currentUser.email.toString());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    avatarUrl: _currentUser?.avatarUrl,
                    onTap: () async {

print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
         
              showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () async{
                       File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image,null);     
                          setState(() { });
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () async{
                       File image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image,null);     
                          setState(() { }); 
                          
    Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
             });         
                    },
                  ),
                  Text(
                      "${_currentUser.displayName ?? 'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ManageProfileInformationWidget(
              currentUser: _currentUser,
            ),
          )
        ],
      ),
    );
  }
}


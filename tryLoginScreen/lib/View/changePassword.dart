import 'package:flutter/material.dart';
import 'package:tryLoginScreen/View/profile/manage_profile_information_widget.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class ChangePasswordPage extends StatelessWidget {
        UserModel _currentUser = locator.get<UserController>().currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ), 
  body: 
         Center(
           child: ManageProfileInformationWidget(
                  currentUser: _currentUser,
                ),
         ),
       
      ),
    );
  }
}
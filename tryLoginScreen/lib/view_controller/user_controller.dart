import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/homeview.dart';

import '../locator.dart';
import '../model/user_model.dart';
import '../repository/auth_repo.dart';
import '../repository/storage_repo.dart';

class UserController {
  UserModel _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    
    //UserModel user;
     

    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File image,String email) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(image,email);
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.email);
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password,SharedPreferences logindata}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password,logindata: logindata);
        

    try{
      _currentUser.avatarUrl = await getDownloadUrl();
    }catch(e)
    {
      print(e);
    }

  }

  //
Future<void> signInWithGoogle(SharedPreferences logindata) async {
    _currentUser = await _authRepo.signInWithGoogle(logindata);
      print('llllllllllll in google:'+_currentUser.uid);
      
    try{
      _currentUser.avatarUrl = await getDownloadUrl();
    }catch(e)
    {
      print(e);
    }

//     if(_currentUser.uid!=null)
//     {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomeView())
//       );
//     }  
//     try{
//     _currentUser.avatarUrl = await getDownloadUrl();
//  print('userconrollweeeeeeeeeeeeee ggoggggggggle'+_currentUser.avatarUrl.toString());
//      }catch(e)
//     {
//       print(e);
//     }
  }

  Future<void> signInWithFacebook(BuildContext context,SharedPreferences logindata) async {
    _currentUser = await _authRepo.signInWithFacebook(logindata);
    print('llllllllllll in facebookkkkkkkk:'+_currentUser.uid);
    
    try{
      _currentUser.avatarUrl = await getDownloadUrl();
    }catch(e)
    {
      print(e);
    }
  }
//

Future<void> signUpWithEmailAndPassword(BuildContext context,
     {String email, String password,String username,String gender,String dob,String phone,SharedPreferences logindata}) async {
    _currentUser = await _authRepo.signUpWithEmailAndPassword(context,
        email: email, password: password,username:username,gender: gender,dob:dob,phone:phone,logindata: logindata);

  //  _currentUser.avatarUrl = await getDownloadUrl();
  }

  void updateDisplayName(String displayName) {
    _currentUser.displayName = displayName;
    _authRepo.updateDisplayName(displayName);
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authRepo.validatePassword(password);
  }

  void updateUserPassword(String password) {
    _authRepo.updatePassword(password);
  }

  Future<bool> initCheckPref() async{

    SharedPreferences pref=await SharedPreferences.getInstance();
    print('bbbbbbbbbbooooooooooollllllll:'+pref.getBool('isUser').toString());
    if(pref.getBool('isUser'))
    {
        return true;
    }
    return false;
  }

  Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
  }

}

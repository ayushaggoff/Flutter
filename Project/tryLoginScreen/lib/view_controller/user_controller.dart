import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

Future<String> getAvatarUrl(String email) async {
    return await _storageRepo.getUserProfileImage(email);
  }
  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.email);
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);
        

    try{
      _currentUser.avatarUrl = await getDownloadUrl();
    }catch(e)
    {
      print(e);
    }

  }

  //
Future<void> signInWithGoogle() async {
    _currentUser = await _authRepo.signInWithGoogle();
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

  Future<void> signInWithFacebook() async {
    _currentUser = await _authRepo.signInWithFacebook();
    print('llllllllllll in facebookkkkkkkk:'+_currentUser.uid);
    
    try{
      _currentUser.avatarUrl = await getDownloadUrl();
    }catch(e)
    {
      print(e);
    }
  }
//

Future<void> signUpWithEmailAndPassword(
     {String email, String password,String username,String gender,String dob,String phone}) async {
    _currentUser = await _authRepo.signUpWithEmailAndPassword(
        email: email, password: password,username:username,gender: gender,dob:dob,phone:phone,);

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





//   void notificationOn()
//   {
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
//  Future selectNotification(String payload)async{
//    await flutterLocalNotificationsPlugin.cancelAll();
//  }
//  Future<dynamic>mybackgroundHandler(Map<String,dynamic>message)
// {
//  return _LoginViewState()._showNotification(message);
// }
          

//     var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

// var initializationSettings = InitializationSettings(
//     initializationSettingsAndroid, null);

     
     
//  flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     onSelectNotification: selectNotification);


   

 

//     _firebaseMessaging.configure(
//       onBackgroundMessage: mybackgroundHandler ,
      



// onMessage: (Map<String,dynamic>message) async{
//           print("Message:$message");
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text( '${message['notification']['title']}'),
//                 content: Text('${message['notification']['body']}'),
//                 actions: <Widget>[
//                   FlatButton(
//                     child: Text('Ok'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               );
//            });
//         },
//         onResume: (Map<String,dynamic>message) async{
//           print("Message:$message");
          
//         },
//         onLaunch: (Map<String,dynamic>message) async{
//           print("Message:$message");
       
//         },

//     );

//   }
//   Future _showNotification(Map<String,dynamic>message) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 
//         'your channel name', 
//         'your channel description',
//         importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
   
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         message['notification']['title'],
//        message['notification']['body'],
//         platformChannelSpecifics,
//         payload: 'Default_Sound');
//     }






 // }

}

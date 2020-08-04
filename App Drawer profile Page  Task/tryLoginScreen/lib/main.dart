import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/profileview.dart';
import 'package:tryLoginScreen/View/registerationview.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'View/dashboardview.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'View/homeview.dart';
import 'View/loginview.dart';
import 'locator.dart';
//import 'model/user.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'push_nofitications.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {  


  @override
  MyAppState createState() => MyAppState();
}

// Future<dynamic>mybackgroundHandler(Map<String,dynamic>message)
// {
//  return MyAppState()._showNotification(message);
// }

class MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
 Future selectNotification(String payload)async{
   await flutterLocalNotificationsPlugin.cancelAll();
 }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
//     var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

// var initializationSettings = InitializationSettings(
//     initializationSettingsAndroid, null);
//  flutterLocalNotificationsPlugin.initialize(initializationSettings,
//     onSelectNotification: selectNotification);

//     _firebaseMessaging.configure(
//       onBackgroundMessage: mybackgroundHandler ,
//       // onMessage:  (Map<String,dynamic>message) async{
//       //     print("onMessage: $message");
//       //   showDialog(
//       //       context: context,
//       //       builder: (context) {
//       //         return AlertDialog(
//       //           title: Text( 'new message arived'),
//       //           content: Text('i want ${message['data']['title']} for ${message['data']['price']}'),
//       //           actions: <Widget>[
//       //             FlatButton(
//       //               child: Text('Ok'),
//       //               onPressed: () {
//       //                 Navigator.of(context).pop();
//       //               },
//       //             ),
//       //           ],
//       //         );
//       //      });
//       //   }



// onMessage: (Map<String,dynamic>message) async{
//           print("Message:$message");
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text( 'new message arived'),
//                 content: Text('i want ${message['data']['title']} for ${message['data']['price']}'),
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
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text( 'new message arived'),
//                 content: Text('i want ${message['data']['title']} for ${message['data']['price']}'),
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
//         onLaunch: (Map<String,dynamic>message) async{
//           print("Message:$message");
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text( 'new message arived'),
//                 content: Text('i want ${message['data']['title']} for ${message['data']['price']}'),
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
    }

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFFF2893),
        accentColor: Color(0xFF000000),
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
      ),
      routes: {
        HomeView.route: (context) => HomeView(),
        LoginView.route: (context) => LoginView(),
        ProfileView.route: (context) => ProfileView(),
      },    
      initialRoute:  LoginView.route,
    );

  
  }
}

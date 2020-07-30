import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/profileview.dart';
import 'package:tryLoginScreen/View/registerationview.dart';
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


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      initialRoute: LoginView.route,
    );
  }
}

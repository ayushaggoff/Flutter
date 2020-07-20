import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model
{
  String _email;
  String _password;

  String get email {
    return _email;
  }
String get password {
    return _password;
  }

  void set email(String email) {
    _email = email;
   notifyListeners();
  }

  void set password(String password) {
    _password = password;
   notifyListeners();
  }
  void  SharedPref()
  async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  void  PutSharedPref()
 async {  
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    password = prefs.getString('password');
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString('email', email);
    // prefs.setString('password', password);
  }
}
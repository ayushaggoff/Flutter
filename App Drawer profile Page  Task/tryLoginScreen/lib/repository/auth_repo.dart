import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import '../model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin=new FacebookLogin();

  AuthRepo();

  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential =
        GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
     return UserModel(user.uid,
        displayName: user.displayName);
  }

  Future<UserModel> signInWithFacebook() async {

 var result =await facebookLogin.logIn(['email']);
      print('//////////REEEEEEEEEEEEEEEsul/////////////////////////////'+result.status.toString());
      if(result.status==FacebookLoginStatus.loggedIn)
      {
        final AuthCredential credential=FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user=(await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print('signed in'+ user.displayName.toString());
        return UserModel(user.uid,
        displayName: user.displayName);
      }
  }


  Future<UserModel> signInWithEmailAndPassword(
      {String email, String password}) async {
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      
        print('checkinggg:'+authResult.toString());
    return UserModel(authResult.user.uid,
        displayName: authResult.user.displayName);
  }


  Future<UserModel> signUpWithEmailAndPassword(
      {String email, String password}) async {
     print('saemaillllllllll:'+email);
AuthResult authResult;
//try{
    authResult = await _auth.createUserWithEmailAndPassword(
    email: email, password: password);
    print('sasasdaasd:'+authResult.toString());
    return UserModel(authResult.user.uid,
        displayName: authResult.user.displayName);
  }

  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser();
    return UserModel(firebaseUser?.uid,
        displayName: firebaseUser?.displayName);
  }

  Future<void> updateDisplayName(String displayName) async {
    var user = await _auth.currentUser();

    user.updateProfile(
      UserUpdateInfo()..displayName = displayName,
    );
  }

  Future<bool> validatePassword(String password) async {
    var firebaseUser = await _auth.currentUser();

    var authCredentials = EmailAuthProvider.getCredential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = await _auth.currentUser();
    firebaseUser.updatePassword(password);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = new FacebookLogin();

  AuthRepo();

  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    updateDisplayName(googleUser.displayName);
    user.updateEmail(googleUser.email);
    String name, gender, dob, phone;
    final flag = await emailCheck(googleUser.email);
    if (flag) {
      Firestore.instance
          .collection("users")
          .document(googleUser.email)
          .setData({
        "username": googleUser.displayName,
        "email": googleUser.email,
        "dob": "",
        "gender": "",
        "phone": ""
      });
    } else {
      final results = await Firestore.instance
          .collection("users")
          .document(googleUser.email)
          .get()
          .then((value) {
        print('mmmmmmmmmppppppp:' + value.data["username"]);
        name = value.data["username"];
        gender = value.data["gender"];
        dob = value.data["dob"];
        phone = value.data["phone"];
        updateDisplayName(value.data["username"]);
      });
    }
    return UserModel(user.uid,
        displayName: name,
        email: googleUser.email,
        gender: gender,
        dob: dob,
        phone: phone);
  }

  Future<UserModel> signInWithFacebook() async {
    Map userProfile;
    String email;
    var result = await facebookLogin.logIn(
      ['email'],
    );
    if (result.status == FacebookLoginStatus.loggedIn) {
      final token = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      userProfile = profile;
      email = userProfile['email'];

      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;

      user.updateEmail(email);
      print('inside auth repo in fb signed in display nAME' +
          user.displayName.toString());
      String name, gender, dob, phone;
      final flag = await emailCheck(email);
      if (flag) {
        Firestore.instance.collection("users").document(email).setData({
          "username": user.displayName,
          "email": email,
          "dob": "",
          "gender": "",
          "phone": ""
        });
      } else {
        final results = await Firestore.instance
            .collection("users")
            .document(email)
            .get()
            .then((value) {
          name = value.data["username"];
          gender = value.data["gender"];
          dob = value.data["dob"];
          phone = value.data["phone"];
          updateDisplayName(value.data["username"]);
        });
      }
      return UserModel(user.uid,
          displayName: name,
          email: email,
          phone: phone,
          gender: gender,
          dob: dob);
    }
  }

  Future<UserModel> signInWithEmailAndPassword(
      {String email, String password}) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    updateDisplayName(user.displayName);
    String name, gender, dob, phone;
    final flag = await emailCheck(user.email);
    if (flag) {
      Firestore.instance.collection("users").document(email).setData({
        "username": user.displayName,
        "email": email,
        "gender": "",
        "dob": "",
        "phone": "",
      });
    } else {
      final results = await Firestore.instance
          .collection("users")
          .document(email)
          .get()
          .then((value) {
        print('mmmmmmmmmppppppp:' + value.data["username"]);
        name = value.data["username"];
        gender = value.data["gender"];
        dob = value.data["dob"];
        phone = value.data["phone"];
        updateDisplayName(value.data["username"]);
      });
    }
    return UserModel(user.uid,
        displayName: name,
        email: email,
        dob: dob,
        gender: gender,
        phone: phone);
  }

  Future<UserModel> signUpWithEmailAndPassword({
    String email,
    String password,
    String username,
    String gender,
    String dob,
    String phone,
  }) async {
    try {
      var userv = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = userv.user;
      updateDisplayName(username);
      final flag = await emailCheck(user.email);
      if (flag) {
        Firestore.instance.collection("users").document(user.email).setData({
          "username": username,
          "email": user.email,
          "gender": gender,
          "dob": dob,
          "phone": phone,
        });
      } else {
        final results = await Firestore.instance
            .collection("users")
            .document(email)
            .get()
            .then((value) {
          username = value.data["username"];
          gender = value.data["gender"];
          dob = value.data["dob"];
          phone = value.data["phone"];
          updateDisplayName(value.data["username"]);
        });
      }
      return UserModel(user.uid,
          displayName: username,
          email: email,
          gender: gender,
          dob: dob,
          phone: phone);
    } catch (e) {}
  }

  Future<UserModel> checkgetuser(SharedPreferences logindata) async {
    var firebaseUser = await _auth.currentUser();
    String email, name, gender, dob, phone;
    firebaseUser.updateEmail(logindata.get("emailpref"));
    email = logindata.get("emailpref");
    final flag = await emailCheck(email);

    final results = await Firestore.instance
        .collection("users")
        .document(email)
        .get()
        .then((value) {
      name = value.data["username"];
      gender = value.data["gender"];
      dob = value.data["dob"];
      phone = value.data["phone"];
    });

    return UserModel('12',
        displayName: name,
        email: email,
        phone: phone,
        gender: gender,
        dob: dob);
  }

  Future<FirebaseUser> getUserFirebase() async {
    var firebaseUser = await _auth.currentUser();
    return firebaseUser;
  }

  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser();
    SharedPreferences logindata = await SharedPreferences.getInstance();
    String name, email, gender, dob, phone;
    if (firebaseUser == null) return null;
    final results = await Firestore.instance
        .collection("users")
        .document(firebaseUser?.email)
        .get()
        .then((value) {
      name = value.data["username"];
      email = value.data["email"];
      gender = value.data["gender"];
      dob = value.data["dob"];
      phone = value.data["phone"];
      if (email != null) firebaseUser.updateEmail(email);
      firebaseUser.updateProfile(
          UserUpdateInfo()..displayName = value.data["username"]);
    });
    String remail = firebaseUser.email;
    return UserModel(firebaseUser?.uid,
        displayName: name,
        email: remail,
        gender: gender,
        dob: dob,
        phone: phone);
  }

  Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
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
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
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

  Future<bool> isSignedIn() async {
    var currentuser = await _auth.currentUser();
    return currentuser != null;
  }

  Future<void> SignOUt() async {
    await _auth.signOut();
  }
  errorManage() {}
}

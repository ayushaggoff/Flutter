import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin=new FacebookLogin();

  AuthRepo();

  Future<UserModel> signInWithGoogle(SharedPreferences logindata) async {
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential =
        GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

      print("////////////////sssssssssss/////ddd//////////////////////////");

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in ///////////////////////////////////////////////" + user.displayName);
     //   print("signed in ////////////////////eemail//////////////" + user.email);


  //

    final flag=await emailCheck(googleUser.email);

      if(flag)
      { 
           print("signed in google    inside flag////////////////");
        Firestore.instance.collection("users").document(googleUser.email).setData({
          "username": user.displayName,
          "email" :googleUser.email,
        });
      }
      else{
          final results = await Firestore.instance.collection("users").document(googleUser.email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      
      updateDisplayName(value.data["username"]);
   
    });


      }
  


  //
  
logindata.setString("emailpref", googleUser.email);
          logindata.setString("displaypref", user.displayName);


    
     return UserModel(user.uid,
        displayName: user.displayName,
        email: googleUser.email,
        );
  }

// //         final currentUser = await _auth.currentUser();
// //     final GoogleSignInAccount account = await _googleSignIn.signIn();
// //     final GoogleSignInAuthentication _googleAuth = await account.authentication;
// //     final AuthCredential credential = GoogleAuthProvider.getCredential(
// //       idToken: _googleAuth.idToken,
// //       accessToken: _googleAuth.accessToken,
// //     );




// //      print('heeeeereeeee');
     
// //     await currentUser.linkWithCredential(credential);
// //         print('lololo');

// //     //await updateUserName(_googleSignIn.currentUser.displayName, currentUser);
      
// //     }s
    
// //     print("signed in " + user.displayName);
// //      return UserModel(user.uid,
// //         displayName: user.displayName);
// //   }


// ///////////////////////////////




//   Future<UserModel> signInWithGoogle() async {
//     final GoogleSignInAccount googleUser =
//         await _googleSignIn.signIn();
//     final GoogleSignInAuthentication googleAuth =
//         await googleUser.authentication;

//     final AuthCredential credential =
//         GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
// FirebaseUser user;
//     try{
//      user =
//         (await _auth.signInWithCredential(credential)).user;
//     }catch(e)
//     {
//           print('eeeeeeeeee:'+e);

//         final currentUser = await _auth.currentUser();
//     final GoogleSignInAccount account = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication _googleAuth = await account.authentication;
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       idToken: _googleAuth.idToken,
//       accessToken: _googleAuth.accessToken,
//     );

//      await currentUser.linkWithCredential(credential);



    
      
//     }
    
//     print("signed in " + user.displayName);
//      return UserModel(user.uid,
//         displayName: user.displayName);
//   }








///////////////////////////////////////








  Future<UserModel> signInWithFacebook(SharedPreferences logindata) async {
Map userProfile;
String email;
 var result =await facebookLogin.logIn(['email']);
      print('//////////REEEEEEEEEEEEEEEsul/////////////////////////////'+result.status.toString());
      if(result.status==FacebookLoginStatus.loggedIn)
      {
          


        //

         print('///////////////////////////////////////////////////////////////////');
      final token = result.accessToken.token;
      final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      print(profile);  
      userProfile = profile;
      email=userProfile['email'];
     



        //
        final AuthCredential credential=FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user=(await FirebaseAuth.instance.signInWithCredential(credential)).user;
       
       
        print('inside auth repo in fb signed in display nAME'+ user.displayName.toString());
       
             //  print('inside auth repo in fb signed in DISPLAY EMAIL'+ user.email.toString());

      //

    final flag=await emailCheck(email);

      if(flag)
      { 
           print("signed in google    inside flag////////////////");
        Firestore.instance.collection("users").document(email).setData({
          "username": user.displayName,
          "email" :email,
        });
      }
      else{
          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      
      updateDisplayName(value.data["username"]);
   
    });


      }
  

  //
          logindata.setString("emailpref", email);
          logindata.setString("displaypref", user.displayName);

        return UserModel(user.uid,
        displayName: user.displayName,
        email: email);
      }
  }


  Future<UserModel> signInWithEmailAndPassword(
      {String email, String password,SharedPreferences logindata}) async {
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      
        print('checkinggg:'+authResult.toString());


         //

    final flag=await emailCheck(authResult.user.email);

      if(flag)
      {  
        Firestore.instance.collection("users").document(authResult.user.email).setData({
          "username": authResult.user.displayName,
          "email" :authResult.user.email,
        });
      }else{
        //

          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      
      updateDisplayName(value.data["username"]);
   
    });



      //

      }


  //


  //  getUser();





logindata.setString("emailpref", email);
          logindata.setString("displaypref", authResult.user.displayName);


    return UserModel(authResult.user.uid,
        displayName: authResult.user.displayName,
        email: email);
  }


  Future<UserModel> signUpWithEmailAndPassword(
      {String email, String password,String username,SharedPreferences logindata}) async {
     print('saemaillllllllll:'+email);
AuthResult authResult;
//try{
    authResult = await _auth.createUserWithEmailAndPassword(
    email: email, password: password);
    print('sasasdaasd:'+authResult.toString());

    updateDisplayName(username);
         //

    final flag=await emailCheck(authResult.user.email);

      if(flag)
      {  
        Firestore.instance.collection("users").document(authResult.user.email).setData({
          "username": username,
          "email" :authResult.user.email,
        });
      }
      else{
          //

          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      
      updateDisplayName(value.data["username"]);
   
    });



      //

      }

  //


//    getUser();

 

logindata.setString("emailpref", email);
          logindata.setString("displaypref", authResult.user.displayName);



    return UserModel(authResult.user.uid,
        displayName: authResult.user.displayName,
        email: email);
  }

  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser();

//
      print('mmmmmmmmmppp'+firebaseUser.email);

 final results = await Firestore.instance.collection("users").document(firebaseUser.email).get()
 .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      
      firebaseUser.updateProfile(UserUpdateInfo()..displayName = value.data["username"]);
    });

//

/////
//     final result = await Firestore.instance
//         .collection('users')
//         .where('email', isEqualTo:'sureshkansal104@gmail.com' )
//         .getDocuments();


// //result.documents.toString();
//      print("/////////////nnnnnnnn//////:getUser"+result.documents.toString());
//      print("//////////////naaaaaa/////:getUser"+result.metadata.toString());
      
// final abc = await Firestore.instance.collection("users").getDocuments().then((querySnapshot) {

//     querySnapshot.documents.forEach((result) {
//         print('bbbbbbbbbbbbbbbbbbbbbbbbbbb');

//       print(result.data.values.where(("email") => "poolpool@gmail.com"));
//     });
//   });







////
    
    
    



    return UserModel(firebaseUser?.uid,
        displayName: firebaseUser?.displayName,
        email:firebaseUser?.email );
  }

  Future<UserModel> UpdateUser(String displayName,String email) async {
    var firebaseUser = await _auth.currentUser();

   final results = await Firestore.instance.collection("users").document(email).get()
 .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
             firebaseUser.updateEmail( email);

      firebaseUser.updateProfile(UserUpdateInfo()..displayName = value.data["username"]);
      updateDisplayName(value.data["username"]);
    });
              //( logindata.get("emailpref"));

    //locator.get<UserController>().currentUser.displayName=logindata.get("displaypref");
 
 
    return UserModel("0",
        displayName: displayName,
        email:email );
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

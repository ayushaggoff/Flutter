import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tryLoginScreen/View/homeview.dart';
import '../model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthRepo {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin=new FacebookLogin();

  AuthRepo();

  Future<UserModel> signInWithGoogle( SharedPreferences logindata) async {
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
    //print("signed in ///////////////////////////////////////////////" + user.displayName);
     //   print("signed in ////////////////////eemail//////////////" + user.email);

    updateDisplayName(googleUser.displayName);

  //
String name,gender,dob,phone;

    final flag=await emailCheck(user.email);

      if(flag)
      { 
           print("signed in google    inside flag////////////////");
        Firestore.instance.collection("users").document(googleUser.email).setData({
          "username": googleUser.displayName,
          "email" :googleUser.email,
          "dob":"",
          "gender":"",
          "phone":""
        });
          //  Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => HomeView()),
          //           );

      }
      else{
          final results = await Firestore.instance.collection("users").document(googleUser.email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
       name=value.data["username"];
       gender=value.data["gender"];
       dob=value.data["dob"];
       phone=value.data["phone"]; 
      updateDisplayName(value.data["username"]);
       //  updateDisplayName(value.data["username"]);
    // Navigator.push(context,
    //                 MaterialPageRoute(builder: (context) => HomeView()),
    //                 );

    });


      }
  


  //
  
logindata.setString("userpref", user.uid);
logindata.setString("emailpref", user.email);
logindata.setString("displaypref", googleUser.displayName);
logindata.setString("genderpref",gender);
logindata.setString("dobpref", dob);
logindata.setString("phonepref", phone);


    
     return UserModel(user.uid,
        displayName: name,
        email: googleUser.email,
        gender: gender,
        dob: dob,
        phone: phone );
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
 var result =await facebookLogin.logIn(['email'],);
      print('//////////REEEEEEEEEEEEEEEsul/////////////////////////////'+result.status.toString());
      if(result.status==FacebookLoginStatus.loggedIn)
      {
          


        //

         print('///////////////////////////////////////////////////////////////////');
      final token = result.accessToken.token;
      final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      userProfile = profile;
      email=userProfile['email'];
     //print(userProfile);
      print("///////////////////\\\\\\\\\\\\\\\\\\facebook profile:"+userProfile.toString());  



        //
        final AuthCredential credential=FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        final FirebaseUser user=(await FirebaseAuth.instance.signInWithCredential(credential)).user;
       
       
        print('inside auth repo in fb signed in display nAME'+ user.displayName.toString());
       
             //  print('inside auth repo in fb signed in DISPLAY EMAIL'+ user.email.toString());

      //
String name,gender,dob,phone;

    final flag=await emailCheck(email);

      if(flag)
      { 
           print("signed in google    inside flag////////////////");
        Firestore.instance.collection("users").document(email).setData({
          "username": user.displayName,
          "email" :email,
          "dob":"",
          "gender":"",
          "phone":""
        });
      }
      else{
          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
           name=value.data["username"];
       gender=value.data["gender"];
       dob=value.data["dob"];
       phone=value.data["phone"]; 
      updateDisplayName(value.data["username"]);
   
    });


      }
  

  //
          logindata.setString("emailpref", email);
          logindata.setString("displaypref", user.displayName);
          logindata.setString("userpref", user.uid);

logindata.setString("genderpref",gender);
logindata.setString("dobpref", dob);
logindata.setString("phonepref", phone);

        return UserModel(user.uid,
        displayName: name,
        email: email,
        phone: phone,
        gender: gender,
        dob: dob);
      }
  }


  Future<UserModel> signInWithEmailAndPassword(
      {String email, String password,SharedPreferences logindata}) async {
  FirebaseUser user =( await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;
      
          updateDisplayName(user.displayName);
        print('checkinggg:'+user.email.toString());

String name,gender,dob,phone;
         //

    final flag=await emailCheck(user.email);

      if(flag)
      {  
        Firestore.instance.collection("users").document(email).setData({
          "username": user.displayName,
          "email" :email,
            "gender":"",
          "dob":"",
          "phone":"",
        });
      }else{
        //

          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
       name=value.data["username"];
       gender=value.data["gender"];
       dob=value.data["dob"];
       phone=value.data["phone"]; 
      updateDisplayName(value.data["username"]);
   
    });



      //

      }


  //


  //  getUser();





logindata.setString("emailpref", email);
          logindata.setString("displaypref", name);
logindata.setString("userpref", user.uid);


logindata.setString("genderpref",gender);
logindata.setString("dobpref", dob);
logindata.setString("phonepref", phone);



    return UserModel(user.uid,
        displayName: name,
        email: email,
        dob: dob,
        gender: gender,
        phone: phone);
  }


  Future<UserModel> signUpWithEmailAndPassword(BuildContext context,
      {String email, String password,String username,String gender,String dob,String phone,SharedPreferences logindata}) async {
     print('saemaillllllllll:'+email);
//AuthResult authResult;
//try{
  FirebaseUser user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;  
   // FirebaseUser user = await _auth.createUserWithEmailAndPassword(
  //  email: email, password: password);
    print('sasasdaasd:'+user.email.toString());



    updateDisplayName(username);
         //

    final flag=await emailCheck(user.email);

      if(flag)
      {  

        print('herere///////////////////////////');
        Firestore.instance.collection("users").document(user.email).setData({
          "username": username,
          "email" :user.email,
          "gender":gender,
          "dob":dob,
          "phone":phone,
        });
                print('herere////////Firestore.instance.///////////////');

 


print('herere//////// after logindata..///////////////');
        // Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => GalleryView()),
        //             );
      }
      else{
          //

          final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
       username=value.data["username"];
       gender=value.data["gender"];
       dob=value.data["dob"];
       phone=value.data["phone"];
       
      updateDisplayName(value.data["username"]);
    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                    );
    });



      //

      }

  //


//    getUser();

print('herere//////// efore return logindata..///////////////');
 





    return UserModel(user.uid,
        displayName: username,
        email: email, gender:gender, dob:dob,phone:phone);
  }

//
  Future<UserModel> checkgetuser(SharedPreferences logindata) async {
  var firebaseUser = await _auth.currentUser();
    String email,name,gender,dob,phone;
    print('insideeeeeeeeee in getUser email:'+logindata.get("emailpref"));
   
    firebaseUser.updateEmail(logindata.get("emailpref"));
    email =logindata.get("emailpref");
    final flag=await emailCheck(email);
     
      final results = await Firestore.instance.collection("users").document(email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+value.data["username"]);
       name=value.data["username"];
       gender=value.data["gender"];
       dob=value.data["dob"];
       phone=value.data["phone"]; 
     // updateDisplayName(value.data["username"]);
   
    });

  

  //
          

        return UserModel('12',
        displayName: name,
        email: email,
        phone: phone,
        gender: gender,
        dob: dob);
      }
  






//
  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser();
    SharedPreferences logindata = await SharedPreferences.getInstance();

    // print('insideeeeeeeeee in getUser email:'+logindata.get("emailpref"));
    // firebaseUser.updateEmail(logindata.get("emailpref"));
          String name,email,gender,dob,phone;
//
     // print('mmmmmmmmmppp'+firebaseUser.email);

 final results = await Firestore.instance.collection("users").document(firebaseUser.email).get()
 .then((value){
   name=value.data["username"];
   email=value.data["email"];
   gender=value.data["gender"];
   dob=value.data["dob"];
   phone=value.data["phone"];
      print('mmmmmmmmmppppppp:'+value.data["username"]);
      firebaseUser.updateEmail(email);
      
      firebaseUser.updateProfile(UserUpdateInfo()..displayName = value.data["username"]);
    });

//

/////
//     final result = await Firestore.instance
//         .collection('users')
//         .where('email', isEqualTo:'s' )
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
        displayName: name,
        email:firebaseUser?.email,
         gender: gender,
         dob: dob,
         phone: phone);
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
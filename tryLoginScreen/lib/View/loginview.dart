import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/registerationview.dart';

import 'package:tryLoginScreen/view_controller/user_controller.dart';

import '../locator.dart';
//import '../model/user.dart';
import 'dart:async';



import 'homeview.dart';

class LoginView extends StatefulWidget {
    static String route = "login";

  @override
  _LoginViewState createState() => _LoginViewState();
}



Future<dynamic>mybackgroundHandler(Map<String,dynamic>message)
{
 return _LoginViewState()._showNotification(message);
}




class _LoginViewState extends State<LoginView> {

SharedPreferences logindata;


 FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
 final FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
 Future selectNotification(String payload)async{
  await flutterLocalNotificationsPlugin.cancelAll();
 }

@override
  void initState() {
    // TODO: implement initState
    super.initState();


void initalizeSharedpref()
async {
  logindata =await SharedPreferences.getInstance();
 
  try {
             

        if(logindata?.getBool==null)
        {
          print('//////nnnnnnnnnneeeeeeeeewwwwwwwwss: if(1st)///////////');
          _firebaseMessaging.subscribeToTopic('News');
          logindata.setBool("newsnotification",true);

        }
        else if(logindata.getBool("newsnotification")){
            _firebaseMessaging.subscribeToTopic('News');
        }else{
           _firebaseMessaging.unsubscribeFromTopic('News');
        }
        }catch(e)
        {

          print('//////nnnnnnnnnneeeeeeeeewwwwwwwwss: catch///////////');
          _firebaseMessaging.subscribeToTopic('News');
          logindata.setBool("newsnotification",true);
        }

          try
          {
          if(logindata.getBool("advertisenotification")){
            _firebaseMessaging.subscribeToTopic('Advertise');
        }else{
           _firebaseMessaging.unsubscribeFromTopic('Advertise');
        }
          }catch(e)
          {
             _firebaseMessaging.subscribeToTopic('Advertise');
        logindata.setBool("advertisenotification",true);
          }

}




     //PushNotificationsManager h=PushNotificationsManager();  
//h.init();
initalizeSharedpref();

    check_if_already_login();
   var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

var initializationSettings = InitializationSettings(
   initializationSettingsAndroid, null);

     
     
 flutterLocalNotificationsPlugin.initialize(initializationSettings,
   onSelectNotification: selectNotification);



 

    _firebaseMessaging.configure(
      onBackgroundMessage: mybackgroundHandler ,
      // onMessage:  (Map<String,dynamic>message) async{
      //     print("onMessage: $message");
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text( 'new message arived'),
      //           content: Text('i want ${message['data']['title']} for ${message['data']['price']}'),
      //           actions: <Widget>[
      //             FlatButton(
      //               child: Text('Ok'),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         );
      //      });
      //   }



onMessage: (Map<String,dynamic>message) async{
          print("Message:$message");
          showDialog(
            context: context,
            builder: (context) {
               return  AlertDialog(  
                                     shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      titlePadding: EdgeInsets.all(0),
                                      title: Container(
                                      //  color: Colors.blue[300],
                                        decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children:[Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${message['notification']['title']}',style: TextStyle(color:Colors.white),),
                                          ),
                                         
            ],),
                                        ),
                                      ),  
                                      content: Text('${message['notification']['body']}'),  
                                      actions: [  
                                        FlatButton(  
                                          child: Text("OK"),  
                                          onPressed: () {  
                                            Navigator.of(context).pop();  
                                         
                                          },  
                                        ),  
                                      ],  
                                    );  
               
               //AlertDialog(
              //   title: Text( '${message['notification']['title']}'),
              //   content: Text('${message['notification']['body']}'),
              //   actions: <Widget>[
              //     FlatButton(
              //       child: Text('Ok'),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //   ],
              // );
           });
        },
        onResume: (Map<String,dynamic>message) async{
          print("Message:$message");
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text( '${message['notification']['title']}'),
          //       content: Text('${message['notification']['body']}'),
          //       actions: <Widget>[
          //         FlatButton(
          //           child: Text('Ok'),
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //         ),
          //       ],
          //     );
          // }
           //);
        },
        onLaunch: (Map<String,dynamic>message) async{
          print("Message:$message");
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: Text( '${message['notification']['title']}'),
        //         content: Text('${message['notification']['body']}'),
        //         actions: <Widget>[
        //           FlatButton(
        //             child: Text('Ok'),
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //         ],
        //       );
        //    });
          
        },

    );

        
          
       
  }
  Future _showNotification(Map<String,dynamic>message) async {
   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
       'your channel id', 
       'your channel name', 
       'your channel description',
       importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
   
   var platformChannelSpecifics = NotificationDetails(
       androidPlatformChannelSpecifics, null);
   await flutterLocalNotificationsPlugin.show(
       0,
       message['notification']['title'],
      message['notification']['body'],
       platformChannelSpecifics,
       payload: 'Default_Sound');
   }









  bool newuser;
  
//   @override
//   void initState() {
//     super.initState();
//       PushNotificationsManager h=PushNotificationsManager();  
// h.init();
//     check_if_already_login();
//   }




void check_if_already_login() async {
    
    logindata = await SharedPreferences.getInstance();

    newuser = (logindata.getBool('login') ?? true);
    print(newuser);

    if (newuser == false) {

     //var firebaseUser = locator.get<UserController>().currentUser;
      print('insideeeeeeeeee in check_if_already_login() blank');
 //firebaseUser.email=logindata.get("emailpref");
// print('insideeeeeeeeee in check_if_already_login() email:'+logindata.get("emailpref"));
    //  locator.get<AuthRepo>().checkgetuser(logindata);
     // locator.get<AuthRepo>().getUser();

     
      //
    //print("shared check email"+logindata.get("emailpref"));
    //print("shared check email"+logindata.get("displaypref"));

 //locator.get<UserController>().currentUser.uid="12";
//locator.get<UserController>().currentUser.email=logindata.get("emailpref");
//locator.get<UserController>().currentUser.displayName=logindata.get("displaypref");
    //locator.get<UserController>().currentUser.email=logindata.get("emailpref");
//locator.get<AuthRepo>().UpdateUser(logindata.get("displaypref"), logindata.get("emailpref"));
        //
      // print('loginnnnnnnnnnnnnnnnnnnnnnnn');
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => HomeView()));

        
    }
  }





  final userController=TextEditingController( );

  final passwordController=TextEditingController();

final _formKey = GlobalKey<FormState>();

  FocusNode _emailFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

  FocusNode _loginbtnFocusNode = FocusNode();

void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}




  @override
  Widget build(BuildContext context) {
  //PushNotificationsManager h=PushNotificationsManager();  
   // userController.text=usermodel.email;
  //  passwordController.text=usermodel.password;
//h.init();
//usermodel.PutSharedPref();
    return  Scaffold(
       body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue[300],
              Colors.blue[600],
              Colors.blue[300]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Image.asset('images/logo_successive.png', fit: BoxFit.cover, 
                    ),
                  ),
                ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Center(
                  child: Form(
                   key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
                     Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                         
                         Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                color: Color.fromRGBO(27, 95, 255, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10)
                              )]
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    focusNode: _emailFocusNode,
                                    autofocus: true,
                                    decoration: InputDecoration( 
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.perm_identity),
                                      border: InputBorder.none
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                                    onFieldSubmitted: (_){
                                    fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                                    }, 
                                    controller: userController,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    focusNode: _passwordFocusNode,
                                    autofocus: true,
                                    obscureText: true,
                                    decoration: InputDecoration( 
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none
                                    ), 
                                    controller: passwordController,
                                    textInputAction: TextInputAction.done,
                                    validator: (password){
                                      Pattern pattern =r'^.{6,12}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(password))
                                        return 'Invalid password';
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (_){
                                    fieldFocusChange(context, _passwordFocusNode, _loginbtnFocusNode);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                           SizedBox(height: 20,),
                          Text("Forgot Password?", style: TextStyle(color: Colors.black),),
                          SizedBox(height: 20,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child:Container(
                               height: 50,
                               width: 120,
                             child: RaisedButton(                            
                              focusNode: _loginbtnFocusNode,
                              autofocus: true,
                              onPressed: ()async {

                           if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                                try {
                                       showAlertDialog(context);

                                  await locator
                                      .get<UserController>()
                                      .signInWithEmailAndPassword(
                                        email: userController.text,
                                        password:
                                        passwordController.text,
                                        logindata: logindata
                                      );
                               logindata.setBool('login', true);
                                logindata.setString("emailpref", userController.text);
                                          Navigator.of(context).pop();  

Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView())
      );
                                
                                } catch (e) {
                                Navigator.pop(context);
                                // Fluttertoast.showToast(
                                // msg: 'Kindly provide correct detials',
                                // backgroundColor: Colors.black,
                                // toastLength: Toast.LENGTH_SHORT,
                                // gravity: ToastGravity.CENTER,
                                
                                // fontSize: 16.0
                                // );
                              
                              logindata.setBool('login', true);
                             
                             showDialog(  
                                  context: context,  
                                  builder: (BuildContext context) {  
                                    return AlertDialog(  
                                     shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      titlePadding: EdgeInsets.all(0),
                                      title: Container(
                                      //  color: Colors.blue[300],
                                        decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children:[Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Error",style: TextStyle(color:Colors.white),),
                                          ),
                                         
            ],),
                                        ),
                                      ),  
                                      content: Text("Kindly provide correct detials"),  
                                      actions: [  
                                        FlatButton(  
                                          child: Text("OK"),  
                                          onPressed: () {  
                                            Navigator.of(context).pop();  
                                           // Navigator.of(context).pop();
                                          },  
                                        ),  
                                      ],  
                                    );  

                             
                             
                             
                             
                              // showDialog(  
                              //   context: context,  
                              //   builder: (BuildContext context) {  
                              //     return AlertDialog(  
                              //       title: Text("Error"),  
                              //       content: Text("Kindly provide correct detials"),  
                              //       actions: [  
                              //         FlatButton(  
                              //           child: Text("OK"),  
                              //           onPressed: () {  
                              //             Navigator.of(context).pop();  
                              //           },  
                              //         ),  
                              //       ],  
                              //     );  
                                },  
                              );  
                              print("Something went wrong!");
                                }
                            }
                            },
                              color: Colors.blue[300],
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text("Login", style: TextStyle(color: Colors.white,fontSize: 16.0, fontWeight: FontWeight.bold ),),
                              ),
                              ),
                                ),
                              ),
                            ]
                          ),
                          SizedBox(height: 20,),
                          Text("Continue with social media", style: TextStyle(color: Colors.black),),
                          SizedBox(height: 20,),
                          Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //Expanded(
                                FlatButton(
                                  onPressed: ()async {  
                                  try {
                                    showAlertDialog(context);

                                  await locator
                                  .get<UserController>()
                                  .signInWithFacebook(context,logindata);
                                  logindata.setBool('login', false);
                                  
                                   Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView())
      );
     // Navigator.pop(context);

                                  //
                                  
                                  //
                                  } catch (e) {
                                    logindata.setBool('login', true);
                                    print("//////////Something went wrong!");
                                                                  Navigator.of(context).pop();

                                 }
                              },
                                //  padding: EdgeInsets.all(0.0),
                                  child: Image.asset('images/icon_facebook_circle.png')
                                ),
                             // ),
                              //Expanded(
                                FlatButton(
                                  //padding: EdgeInsets.all(0.0),
                                
                                  onPressed: ()async {       
                                    print('////////pressed ggggggggggggooooooooooogggg');
                                    try{
                                               showAlertDialog(context);
                                                locator.get<UserController>().signInWithGoogle(logindata).whenComplete(() {
                                                  
logindata.setBool('login', false);
                                        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView())
      );

                                                });

                                   
                                    }
                                    catch(e)
                                    {
                                            Navigator.of(context).pop();
                                            print(e);

                                    }
                                // Navigator.pushNamed(
                                //   context, HomeView.route);
                                  //model.singnInWithGoogleUsingFirebase(context);  
                                  },
                                  child: Image.asset('images/icon_google_multicolored.png'),
                                ),
                              //),
                      ],
                    ),   
                    SizedBox(height: 20,),
                    Container(
                      child:   GestureDetector(
                        onTap: () 
                        {
                          Navigator.pushReplacement(context, new MaterialPageRoute(
                          builder: (context) => new RegisterationPage()
                          ));
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don\'t have an Account? ',
                                style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                ),
                              ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              ),
                            ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ],
              ) ,
            ),                  
            ]),     
        ),      
      ),
                )
              ),
            )
              ]
    )
  )
  //)
 // )  
);
}

  Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
   }
}
 showAlertDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: new Row(
            children: [
               CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
),
               Container(margin: EdgeInsets.only(left: 5),child:Text("    Loading" )),
            ],),
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }
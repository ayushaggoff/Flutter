import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/registerationview.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_bloc.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_event.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_state.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';
import 'dart:async';



import 'homeview.dart';


class LoginPageParent extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> LoginBloc(),
      child: LoginView(), 
      );
  }
}





class LoginView extends StatefulWidget {
    static String route = "login";

  @override
  _LoginViewState createState() => _LoginViewState();
}





class _LoginViewState extends State<LoginView> {








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

LoginBloc loginBloc;


  @override
  Widget build(BuildContext context) {
    loginBloc=BlocProvider.of<LoginBloc>(context);
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
                         BlocListener<LoginBloc,LoginState>(
                            listener: (context,state)
                            {
                              if(state is LoginSuccessfulState){
                                    Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => HomeView()),
                       );
                              }
                            },
                            child: BlocBuilder<LoginBloc,LoginState>(
                            builder: (context,state)
                            {
                              if(state is LoginInitialState){
                                return buildInitialUi();
                              }else if(state is LoginLoadingState){
                                return buildLoadingUi();
                              }else if(state is LoginSuccessfulState){
                                return Container();
                              }else if(state is LoginFailureState){
                             //  return buildFailureUi();
                              return CustomAlertDialog(context);
                              }
                            },
                           ),
                         ),
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
                                  child: StreamBuilder<String>(
                                    stream: loginBloc.emailStream,
                                    builder: (context, snapshot) {

                                      return TextFormField(
                                        focusNode: _emailFocusNode,
                                        onChanged : loginBloc.emailChanged,
                                        autofocus: true,
                                        decoration: InputDecoration( 
                                          hintText: "Email",
                                          errorText: snapshot.error,
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
                                      );
                                    }
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
                          Text("", style: TextStyle(color: Colors.black),),
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
                                  loginBloc.add(LoginButtonPressedEvent(email: userController.text,password: passwordController.text));

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

                                     loginBloc.add(FacebookButtonPressedEvent());

      //                             try {
      //                               showAlertDialog(context);

      //                             await locator
      //                             .get<UserController>()
      //                             .signInWithFacebook(context,logindata);
      //                             logindata.setBool('login', false);
                                  
      //                              Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeView())
      // );
      //                             } catch (e) {
      //                               logindata.setBool('login', true);
      //                               print("//////////Something went wrong!");
      //                                                             Navigator.of(context).pop();

      //                            }
                              },
                                       child: Image.asset('images/icon_facebook_circle.png')
                                ),
                                FlatButton(
    
                                
                                  onPressed: ()async {  
                                    loginBloc.add(GoogleButtonPressedEvent());     
//                                         try{
//                                                showAlertDialog(context);
//                                                 locator.get<UserController>().signInWithGoogle(logindata).whenComplete(() {
                                                  
// logindata.setBool('login', false);
//                                         Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeView())
//       );

//                                                 });

                                   
//                                     }
//                                     catch(e)
//                                     {
//                                             Navigator.of(context).pop();
//                                             print(e);

//                                     }
    
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
                          builder: (context) => new RegisterationPageParent()
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
      Widget buildInitialUi(){
    return Center(
      child: Text(""),
      );
  }
  AlertDialog buildLoadingUi(){
      AlertDialog loading=AlertDialog(
        content: new Row(
            children: [
               CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
),
               Container(margin: EdgeInsets.only(left: 5),child:Text("    Loading" )),
            ],),
      );
    return loading;
  }

    Widget buildFailureUi(){
    return Center(
      child: Text(""),
      );
  }
  CustomAlertDialog(BuildContext context){

    AlertDialog alert=AlertDialog(  
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
                                     // buildInitialUi();
                                            Navigator.pushReplacement(context, new MaterialPageRoute(
                          builder: (context) => new LoginPageParent()
                          ));
                                           // Navigator.of(context).pop();
                                          },  
                                        ),  
                                      ],  
                                    );  


    return alert;
  }

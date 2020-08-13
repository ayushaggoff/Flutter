import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class RegisterationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _registerbtnFocusNode = FocusNode();
String a="1";

void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
   Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
  final nameController=TextEditingController( );
  final emailController=TextEditingController( );
  final passwordController=TextEditingController();

    return Scaffold(
       body: Center(
         child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.blue[600],
                Colors.blue[300],
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
                  //  Text("Registeration", style: TextStyle(color: Colors.white, fontSize: 40),),
                  //   SizedBox(height: 10,),
                  //  Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 18),),
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
              SizedBox(height: 8), 
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                child:Center(
                  child: Form(
                     key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                          SizedBox(height: 60,),
                          Container(
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(30, 95, 255, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                              )]
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                        focusNode: _nameFocusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                              hintText: "Enter User Name",
                              hintStyle: TextStyle(color: Colors.black,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0))
                              ),
                        ),
                        controller: nameController,
                        onSaved: (name)=>  nameController.text= name,
                        onFieldSubmitted: (_){
                        fieldFocusChange(context, _nameFocusNode, _emailFocusNode);
                        },
                      ),
                    ),

                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.phone,
                    //     textAlign: TextAlign.center,
                    //     onChanged: (value) {},
                    //     decoration: InputDecoration(
                    //           hintText: "Enter your Phone",
                    //           hintStyle: TextStyle(color: Colors.black,),
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                    //   ),
                    // ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        focusNode: _emailFocusNode,
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        controller: emailController,

                        onChanged: (value) {},
                        decoration: InputDecoration(
                              hintText: "Enter your Email",
                              hintStyle: TextStyle(color: Colors.black,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0))
                                  ),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                        onSaved: (email)=>  emailController.text= email,
                        onFieldSubmitted: (_){
                        fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                       focusNode: _passwordFocusNode,
                       autofocus: true,
                       obscureText: true,
                        textAlign: TextAlign.center,
                        controller: passwordController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                              hintText: "Enter your Password",
                              hintStyle: TextStyle(color: Colors.black,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                      textInputAction: TextInputAction.done,
                      validator: (password){
                      Pattern pattern =r'^.{6,12}$';
                      RegExp regex = new RegExp(pattern);
                      if (!regex.hasMatch(password))
                        return 'Invalid password';
                      else
                        return null;
                      },
                      onFieldSubmitted:  (_){
                      fieldFocusChange(context, _passwordFocusNode,_registerbtnFocusNode );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 5,
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(32.0),
                      child: MaterialButton(
                        focusNode: _registerbtnFocusNode,
                       autofocus: true,
                        onPressed: () async {
                try{
                  if(_formKey.currentState.validate()){
                  _formKey.currentState.save();

                  await locator.get<UserController>()
                  .signUpWithEmailAndPassword (
                  email: emailController.text,
                  password:passwordController.text,username:nameController.text);

                  

                // locator.get<AuthRepo>().updateDisplayName(nameController.text);                


final flag=await emailCheck(emailController.text);

        print('///////before///////username:'+nameController.text);


// // print("//fllllllllllllllag:"+flag.toString());
//       if(flag)
//       {  
//         print('//////////////username:'+nameController.text);
//         Firestore.instance.collection("users").document(emailController.text).setData({
//           "username":a,
//           "email" :"emailController.text",
//                    }    );

// //                var myDatabase = Firestore.instance;
// print("////////////////////////username:"+nameController.text);
// print("////////////////////////username:"+emailController.text);
// myDatabase.collection("users").add({
//         "username": nameController.text,
//         "email" :emailController.text,
      
//       }).then((_) {
//         print("////////////////////////One document added.pppppppppppppppp");

//       });                  
  // }           
    locator.get<AuthRepo>().getUser();
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  }
                } catch(signUpError) {
                 if(signUpError is PlatformException) {
                  if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {

                        showDialog(  
                                  context: context,  
                                  builder: (BuildContext context) {  
                                    return AlertDialog(  
                                      title: Text("Error"),  
                                      content: Text("EMAIL ALREADY IN USE"),  
                                      actions: [  
                                        FlatButton(  
                                          child: Text("OK"),  
                                          onPressed: () {  
                                            Navigator.of(context).pop();  
                                          },  
                                        ),  
                                      ],  
                                    );  
                                  },  
                                );  
                  }
                }
              }                  
            },
            minWidth: 200.0,
            height: 45.0,
            child: Text(
              "Register",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
            ),
          ),
      )
           ],
              ),
                            ),
            ),
            ]
            ),
          ),
                  ),
                ),
                ),      
            ),
              ]),
           ),
       )
         
      );
    }
}
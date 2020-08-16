import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class RegisterationPage extends StatefulWidget {
  @override
  _RegisterationPageState createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
     SharedPreferences logindata ;
void check_if_already_login() async {
    
    logindata = await SharedPreferences.getInstance();
    }

     @override
     void initState() { 
       super.initState();
         check_if_already_login();
     }

  final _formKey = GlobalKey<FormState>();
int _groupValue = -1;
var myFormat = DateFormat('d-MM-yyyy');
String gender;
TextEditingController dateCtl = TextEditingController();
  final nameController=TextEditingController( );
    final emailController=TextEditingController( );
  final phoneController=TextEditingController( );
  final passwordController=TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  FocusNode _emailFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
    FocusNode _genderFocusNode = FocusNode();


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
                       Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    focusNode: _nameFocusNode,
                                    autofocus: true,
                                   keyboardType: TextInputType.text,
                                    decoration: InputDecoration( 
                                      hintText: "Name",
                                      
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.perm_identity),
                                      border: InputBorder.none
                                    ), 
                                    controller: nameController,
                                    textInputAction: TextInputAction.done,
                                    validator: (name){
                                    
                                      if (name.length==0)
                                        return 'Enter the name';
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (_){
                                    fieldFocusChange(context, _nameFocusNode, _genderFocusNode);
                                    },
                                  ),
                                ),
                   Padding(padding:  EdgeInsets.all(10),
                   child:_genderRadio(_groupValue, _handleRadioValueChanged),
                   ),
                   Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                      
       controller: dateCtl,
       decoration: InputDecoration(
      border: InputBorder.none,
       hintText: "Date of birth",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.date_range),), 
       onTap: () async{
DateTime date = DateTime(1900);
FocusScope.of(context).requestFocus(new FocusNode());

date = await showDatePicker(
              context: context, 
              
              initialDate:DateTime(2019, 1, 1),
              firstDate:DateTime(1900),
              lastDate: DateTime(2100));

dateCtl.text = myFormat.format(date);},)   

                  ),
                    Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    focusNode: _emailFocusNode,
                                    keyboardType: TextInputType.emailAddress,
                                    autofocus: true,
                                    decoration: InputDecoration( 
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.alternate_email),
                                      border: InputBorder.none
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                                    onFieldSubmitted: (_){
                                    fieldFocusChange(context, _emailFocusNode, _phoneFocusNode);
                                    }, 
                                    controller: emailController,
                                  ),
                                ),
                                 Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    focusNode: _phoneFocusNode,
                                    autofocus: true,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration( 
                                      hintText: "Phone",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(MdiIcons.phone,),
                                      border: InputBorder.none
                                    ), 
                                    controller: phoneController,
                                    textInputAction: TextInputAction.done,
                                    validator: (phone){
                                    phoneController.text=phone;
                                      if (phone.length==0)
                                        return 'Enter the phone number';
                                      else if(phone.length<10||phone.length>10)
                                        return 'Phone number should be of 10 digit';
                                      else
                                        return null;
                                    },
                                    onFieldSubmitted: (_){
                                    fieldFocusChange(context, _phoneFocusNode, _passwordFocusNode);
                                    },
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
                                      icon: Icon(Icons.lock_outline,),
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
                                    fieldFocusChange(context, _passwordFocusNode, _registerbtnFocusNode);
                                    },
                                  ),
                                ),
                   
                    
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 5,
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.circular(32.0),
                      child: MaterialButton( 
                        focusNode: _registerbtnFocusNode,
                       autofocus: true,
                        onPressed: () async {
                try{
                  if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
 logindata.setString("emailpref", emailController.text);
                  await locator.get<UserController>()
                  .signUpWithEmailAndPassword (context,
                  email: emailController.text,
                  password:passwordController.text,
                  username:nameController.text,
                  gender: gender,
                  phone: phoneController.text,
                  dob: dateCtl.text);
print('////////////////////hereeeeeeeeeeeee push    homeviewwww');
                  

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
              style: TextStyle( color: Colors.white,fontSize: 16.0),
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

     void _handleRadioValueChanged(int value) {
    setState(() {
      this._groupValue = value;
      if(value==0)
      {
        nameController.text=nameController.text;
        dateCtl=dateCtl;
        gender='Male';
      }else
      {
         gender='Female';
      }
      print('genderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrvalue:'+gender.toString());
    });
  }

_genderRadio(int groupValue, handleRadioValueChanged) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      
      //MdiIcons.genderMaleFemale
      Row(
        children: <Widget>[
          Icon(MdiIcons.genderMaleFemale,),
      //     Text(
      //   'Gender',
      //   style: new TextStyle(fontSize: 16.0),
      // ),
          Radio(
              value: 0,
              focusColor: Colors.blueAccent,
              focusNode: _genderFocusNode,
              groupValue: groupValue,
              
              onChanged: handleRadioValueChanged),
          Text(
            "Male",
            style: new TextStyle(
              fontSize: 14.0,
            ),
          ),
          Radio(
              value: 1,
              groupValue: groupValue,
              
              onChanged: handleRadioValueChanged),
          Text(
            "Female",
            style: new TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      )
    ]);
}


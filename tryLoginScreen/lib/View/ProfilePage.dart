import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/View/profile/avatar.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProbilePageState createState() => _ProbilePageState();
}

class _ProbilePageState extends State<ProfilePage> {
      UserModel _currentUser = locator.get<UserController>().currentUser;

@override
void initState() { 
  super.initState();
  locator.get<AuthRepo>().getUser();

}

    
  final _formKey = GlobalKey<FormState>();
int _groupValue = -1;
var myFormat = DateFormat('d-MM-yyyy');
String gender;

TextEditingController dateCtl = TextEditingController();
  final nameController=TextEditingController();
    final emailController=TextEditingController( );
  final phoneController=TextEditingController( );
  final passwordController=TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();
  
    FocusNode _genderFocusNode = FocusNode();


  FocusNode _registerbtnFocusNode = FocusNode();

String a;



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
int initGender(_currentUser)
{
 
print('////////initGender////////////////////');
        var result=Firestore.instance.collection("users").document(_currentUser.email).get()
      .then((value){
      print('mmmmmmmmmppppppp:'+_currentUser.email);
      emailController.text=_currentUser.email;
       nameController.text=value.data["username"];
        //initGender(value.data["gender"]);
              print('mmmmmmmmmppppppp: dob'+value.data["dob"]);

       dateCtl.text=value.data["dob"];
       phoneController.text=value.data["phone"];
       print('inside profile:'+phoneController.text);
      

 var gen=value.data["gender"];
 a=value.data["gender"];
 print('inside profile   gender:'+gen);
       if(gen=='Male')
  {
    print('insinde profile;'+_currentUser.phone);

       _groupValue=0;
        print("////////here");
      }else if(gen=='Female')
      {
        _groupValue=1;
      }
      });
      print('_groupValue'+_groupValue.toString());
      
return _groupValue;
}
  @override
  Widget build(BuildContext context) {
_groupValue=initGender(_currentUser);
if(a=='Male')
{
  print('heeeeeeeeee');
_groupValue=0;
}else{
  _groupValue=1;
}
       
 print('insinde profile;'+phoneController.text);
    return Scaffold(
    appBar: AppBar(
      title: Text("Porfile"),
    ), 
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
              //Padding(
               // padding: EdgeInsets.all(20),
               // child: Column(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                //  children: <Widget>[
               //   //  Text("Registeration", style: TextStyle(color: Colors.white, fontSize: 40),),
               //   //   SizedBox(height: 10,),
               //   //  Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 18),),
               //   ],
              //  ),
              //),
             // SizedBox(height: 8), 
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
                                 Avatar(
                    avatarUrl: _currentUser?.avatarUrl,
                    onTap: () async {

print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
         
              showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () async{
                       File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                          print("pickkkkkkkkkkkkkkkkkimaaaaageeeeeeee"+image.toString());
                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image,emailController.text);     
                          setState(() { });
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () async{
                       File image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      await locator
                          .get<UserController>()
                          .uploadProfilePicture(image,emailController.text);     
                          setState(() { }); 
                          
    Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
             });         
                    },
                  ),
         
                          SizedBox(height: 10,),
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
                                //    phoneController.text=phone;
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

                  //
                  Firestore.instance.collection("users").document(emailController.text).
                  updateData({"username":nameController.text,
                  "gender": gender,
                  "phone": phoneController.text,
                  "dob": dateCtl.text
                  }).then((_) {
                    _currentUser.displayName=nameController.text;
                   // locator.get<>()
                        showDialog(  
                                  context: context,  
                                  builder: (BuildContext context) {  
                                    return AlertDialog(  
                                      title: Text(""),  
                                      content: Text("Profile is Updated"),  
                                      actions: [  
                                        FlatButton(  
                                          child: Text("OK"),  
                                          onPressed: () {  
                                           // Navigator.of(context).pop();  
                                           Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeView()));
                                          },  
                                        ),  
                                      ],  
                                    );  
                                  },  
                                );
                  });
                  //
print('////////////////////hereeeeeeeeeeeee push    homeviewwww');
                  

                // locator.get<AuthRepo>().updateDisplayName(nameController.text);                


//final flag=await emailCheck(emailController.text);

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
              "Update Profile",
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

    //

 Firestore.instance.collection("users").document(emailController.text).
                  updateData({"username":nameController.text,
                  "gender": gender,
                  "phone": phoneController.text,
                  "dob": dateCtl.text
                  }).then((value) => setState(() {}));


    //

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

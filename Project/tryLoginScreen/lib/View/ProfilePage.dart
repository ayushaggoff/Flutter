import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/View/profile/avatar.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_bloc.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_event.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_state.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class ProfilePage extends StatefulWidget {
  String a;
  ProfilePage(this.a);

  @override
  _ProbilePageState createState() => _ProbilePageState(a);
}

class _ProbilePageState extends State<ProfilePage> {
  String initals="Z";
  DateTime dob;

  _ProbilePageState(this.a);

  final _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  var myFormat = DateFormat('d-MM-yyyy');

  TextEditingController dateCtl = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();

  FocusNode _genderFocusNode = FocusNode();

  FocusNode _registerbtnFocusNode = FocusNode();

  String a;
  String gender, displayName, avatarUrl, email, phone;

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  //..add(InitEvent())
  @override
  Widget build(BuildContext context) 
  {
    print('insinde profile;' + phoneController.text);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body:BlocProvider<ProfilePageBloc>(
        create: (context) => ProfilePageBloc()..add(InitEvent()),
          child:BlocListener<ProfilePageBloc,ProfilePageState>(
                        listener: (context,state)
                        {
                          if(state is ProfileSuccessState){
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomeView()),
                       );
                          }
                        },
                          child: 
          BlocBuilder<ProfilePageBloc, ProfilePageState>(
              builder: (context, state) {
    var bloc=BlocProvider.of<ProfilePageBloc>(context);

            if (state is ProfileInitialState) {
              gender = "Male";
               emailController.text = state.email;
               nameController.text = state.displayName;
              avatarUrl = state.avartarUrl;
              initals = nameController.text.toUpperCase();
              initals = initals[0];
              phoneController.text = state.phone;

              if (state.dob != "") {
                dateCtl.text=state.dob;
               dob = DateFormat('d-MM-yyyy').parse(state.dob);
              } else {
                 dob = DateFormat('d-MM-yyyy').parse("10-01-1700");
              }
              if (state.gender == 'Male') {
                _groupValue = 0;
              } else {
                _groupValue = 1;
              }
              return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                        Colors.blue[600],
                        Colors.blue[300],
                        Colors.blue[300]
                      ])),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Avatar(
                              avatarUrl: avatarUrl,
                              initals: initals,
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Text(
                                              "From where do you want to take the photo?"),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Row(children: [
                                                    Icon(Icons.photo_album),
                                                    Text("  Gallery")
                                                  ]),
                                                  onTap: () async {
                                                    File image = await ImagePicker
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    print(
                                                        "pickkkkkkkkkkkkkkkkkimaaaaageeeeeeee" +
                                                            image.toString());
                                                    try {
                                                      showAlertDialog(context);

                                                      await locator
                                                          .get<UserController>()
                                                          .uploadProfilePicture(
                                                              image,
                                                              emailController
                                                                  .text);
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();

                                                      setState(() {});
                                                    } catch (e) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 25.0)),
                                                GestureDetector(
                                                  child: Row(children: [
                                                    Icon(Icons.camera_alt),
                                                    Text("  Camera"),
                                                  ]),
                                                  onTap: () async {
                                                    File image =
                                                        await ImagePicker
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    try {
                                                      showAlertDialog(context);
                                                      await locator
                                                          .get<UserController>()
                                                          .uploadProfilePicture(
                                                              image,
                                                              emailController
                                                                  .text);
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();

                                                      setState(() {});
                                                    } catch (e) {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              },
                            ),
                          ),
                        ),

                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            child: Center(
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    30, 95, 255, .3),
                                                blurRadius: 20,
                                                offset: Offset(0, 10))
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: StreamBuilder<String>(
                                                stream: BlocProvider.of<ProfilePageBloc>(context).nameStream,
                                                builder: (context, snapshot) {
                                                  return TextFormField(
                                                    focusNode: _nameFocusNode,
                                                    onChanged: bloc.nameChanged,
                                          
                                                    autofocus: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                        hintText: "Name",
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
                                                        icon: Icon(
                                                            Icons.perm_identity),
                                                        border: InputBorder.none),
                                                    controller: nameController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    validator: (name) {
                                                      if (name.length == 0)
                                                        return 'Enter the name';
                                                      else
                                                        return null;
                                                    },
                                                    onFieldSubmitted: (_) {
                                                      fieldFocusChange(
                                                          context,
                                                          _nameFocusNode,
                                                          _genderFocusNode);
                                                    },
                                                  );
                                                }
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(10),
                                              child: _genderRadio(_groupValue,
                                                  _handleRadioValueChanged),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .grey[200]))),
                                                child:  StreamBuilder<String>(
                                                stream: bloc.dobStream,
                                                builder: (context, snapshot) {
                                                    return TextFormField(
                                                      controller: dateCtl,
                                                      onChanged: bloc.dobChanged,
                                                      decoration: InputDecoration(
                                                        errorText: snapshot.error,
                                                        border: InputBorder.none,
                                                        hintText: "Date of birth",
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
                                                        icon:
                                                            Icon(Icons.date_range),
                                                      ),
                                                      onTap: () async {
                                                        DateTime date =
                                                            DateTime(1900);
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                new FocusNode());

                                                        date = await showDatePicker(
                                                            context: context,
                                                            initialDate: dob,
                                                            firstDate:
                                                                DateTime(1900),
                                                            lastDate:
                                                                DateTime(2100));

                                                        dateCtl.text =
                                                            myFormat.format(date);

                                                        // Firestore.instance
                                                        //     .collection("users")
                                                        //     .document(
                                                        //         emailController
                                                        //             .text)
                                                        //     .updateData({
                                                        //   "username":
                                                        //       nameController.text,
                                                        //   "gender": gender,
                                                        //   "phone":
                                                        //       phoneController.text,
                                                        //   "dob": dateCtl.text
                                                        // });
                                                      },
                                                    );
                                                  }
                                                )),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: StreamBuilder<String>(
                                                stream: bloc.emailStream,
                                                builder: (context, snapshot) {
                                                  return TextFormField(
                                                    enabled: false,
                                                    onChanged: bloc.emailChanged,
                                                    focusNode: _emailFocusNode,
                                                    keyboardType:
                                                        TextInputType.emailAddress,
                                                    autofocus: true,
                                                    decoration: InputDecoration(
                                                        hintText: "Email",
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
                                                        icon: Icon(
                                                            Icons.alternate_email),
                                                        border: InputBorder.none),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: (email) =>
                                                        EmailValidator.validate(
                                                                email)
                                                            ? null
                                                            : "Invalid email address",
                                                    onFieldSubmitted: (_) {
                                                      fieldFocusChange(
                                                          context,
                                                          _emailFocusNode,
                                                          _phoneFocusNode);
                                                    },
                                                    controller: emailController,
                                                  );
                                                }
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child:  StreamBuilder<String>(
                                                stream: bloc.phoneStream,
                                                builder: (context, snapshot) {
                                                  return TextFormField(
                                                    focusNode: _phoneFocusNode,
                                                    onChanged: bloc.phoneChanged,
                                                    autofocus: true,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    decoration: InputDecoration(
                                                      errorText: snapshot.error,
                                                        hintText: "Phone",
                                                        hintStyle: TextStyle(
                                                            color: Colors.black),
                                                        icon: Icon(
                                                          MdiIcons.phone,
                                                        ),
                                                        border: InputBorder.none),
                                                    controller: phoneController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    validator: (phone) {
                                                      //    phoneController.text=phone;
                                                      if (phone.length == 0)
                                                        return 'Enter the phone number';
                                                      else if (phone.length < 10 ||
                                                          phone.length > 10)
                                                        return 'Phone number should be of 10 digit';
                                                      else
                                                        return null;
                                                    },
                                                    onFieldSubmitted: (_) {
                                                      fieldFocusChange(
                                                          context,
                                                          _phoneFocusNode,
                                                          _passwordFocusNode);
                                                    },
                                                  );
                                                }
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Material(
                                              elevation: 5,
                                              color: Colors.blue[300],
                                              borderRadius:
                                                  BorderRadius.circular(32.0),
                                              child: MaterialButton(
                                                focusNode:
                                                    _registerbtnFocusNode,
                                                autofocus: true,
                                                onPressed: () async {
                                                  BlocProvider.of<ProfilePageBloc>(context).add(UpdateButtonPressedEvent(displayName: nameController.text,dob: dateCtl.text,email: emailController.text,gender: gender,phone: phoneController.text));
                                                //  Navigator.pushReplacement(context,
                                                //  MaterialPageRoute(builder: (context) => HomeView()),);
                                                },
                                                minWidth: 200.0,
                                                height: 45.0,
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]));
            }
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          })),
    )
    );
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      this._groupValue = value;
      if (value == 0) {
        nameController.text = nameController.text;
        dateCtl = dateCtl;
        gender = 'Male';
      } else {
        gender = 'Female';
      }
      print('genderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrvalue:' + gender.toString());
    });
  }

  _genderRadio(int groupValue, handleRadioValueChanged) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        //MdiIcons.genderMaleFemale
        Row(
          children: <Widget>[
            Icon(
              MdiIcons.genderMaleFemale,
            ),
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

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("    Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

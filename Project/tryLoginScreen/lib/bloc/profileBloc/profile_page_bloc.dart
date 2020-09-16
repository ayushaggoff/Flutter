import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_event.dart';
import 'package:tryLoginScreen/bloc/profileBloc/profile_page_state.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repository/storage_repo.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent,ProfilePageState>
{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
   final dobController = TextEditingController();

final _nameStreamController=BehaviorSubject<String>();
Stream<String> get nameStream => _nameStreamController.stream;
StreamSink<String> get _nameSink { 
  return _nameStreamController.sink;}
Function(String) get nameChanged => _nameStreamController.sink.add;

final _genderStreamController=BehaviorSubject<int>();
Stream<int> get genderstream => _genderStreamController.stream;
StreamSink<int> get _genderSink {
  return _genderStreamController.sink;}
Function(int) get genderChanged => _genderStreamController.sink.add;

final _imageStreamController=BehaviorSubject<String>();
Stream<String> get imageStream => _imageStreamController.stream;
StreamSink<String> get _imageSink {
  return _imageStreamController.sink;}
Function(String) get imageChanged => _imageStreamController.sink.add;


final _dobStreamController=BehaviorSubject<String>();
Stream<String> get dobStream => _dobStreamController.stream;
StreamSink<String> get _dobSink{ 
  return _dobStreamController.sink;}
Function(String) get dobChanged {
  return _dobStreamController.sink.add;}


final _dobPickerStreamController=BehaviorSubject<DateTime>();
Stream<DateTime> get dobPickerStream => _dobPickerStreamController.stream;
StreamSink<DateTime> get _dobPickerSink{ 
  return _dobPickerStreamController.sink;}
Function(DateTime) get dobPickerChanged {
  return _dobPickerStreamController.sink.add;}


final _phoneStreamController=BehaviorSubject<String>();
Stream<String> get phoneStream => _phoneStreamController.stream;
StreamSink<String> get _phoneSink 
{ return _phoneStreamController.sink;}
Function(String) get phoneChanged => _phoneStreamController.sink.add;

final _emailStreamController=BehaviorSubject<String>();
Stream<String> get emailStream => _emailStreamController.stream;
StreamSink<String> get _emailSink {
  return _emailStreamController.sink;}
Function(String) get emailChanged => _emailStreamController.sink.add;

 Future<void> uploadProfilePicture(File image,String email) async {
    UserModel _currentUser;
 
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://tryloginscreen.appspot.com");
     var storageRef = _storage.ref().child("user/profile/$email");
    var uploadTask = storageRef.putFile(image);
    var completedTask = await uploadTask.onComplete;
     String a = await completedTask.ref.getDownloadURL();


  }
   
Future<String> getAvatarUrl(String email) async {
  try{
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://tryloginscreen.appspot.com");
      var tt =   await _storage.ref().child("user/profile/$email").getDownloadURL();
   return   await _storage.ref().child("user/profile/$email").getDownloadURL();
  }catch(ex){
    return null;
  }

    
  }


AuthRepo authRepo;
UserController userController;
  StorageRepo _storageRepo;

ProfilePageBloc() : super(ProfileLoadingState()){
  authRepo=AuthRepo();
}

  @override
  Stream<ProfilePageState> mapEventToState(ProfilePageEvent event) async*{
    FirebaseAuth auth = FirebaseAuth.instance;
    var user=await auth.currentUser();
   
   if(event is InitEvent)

   {
     
   String avartarUrl,displayName,gender,dob,phone; 
        String initials="z";
       await Firestore.instance.collection("users").document(user.email).get()
       .then((value)  async {
       //_nameSink.add(value.data["username"]);
       nameController.text=value.data["username"];
       emailController.text=value.data["email"];
      phoneController.text=value.data["phone"];
        gender=value.data["gender"];       
       dob=value.data["dob"];
       initials=value.data["username"];
       initials = initials[0].toUpperCase();
              if (dob!=null) {
               dobController.text=dob;
              
              } else {
                 dobController.text="01-01-2000";
              }
              if (gender == 'Male') {
                _genderSink.add(0);
              } else {
               _genderSink.add(1);
              } 
     });
      try{
    avartarUrl=await getAvatarUrl(user.email);
      }catch(ex)
      {
        print(ex);
        avartarUrl=null;
      }
    _imageSink.add(avartarUrl);
    //_imageSink.addError(initials);
    yield ProfileInitialState(initials:initials,avartarUrl:avartarUrl,displayName:displayName ,email: user.email,gender: gender,dob: dob.toString(),phone:phone);
   }else if (event is UpdateButtonPressedEvent)
   {
     
     if(event.displayName.isEmpty)
     {
       _nameSink.addError('Please provide name');
     }else if(event.dob=="10-01-1700")
     {
       _dobSink.addError('Please provide date of birth');
     }else if(event.phone.isEmpty)
     {
       _phoneSink.addError('Please provide Phone Number');
     }else if(event.phone.length!=10)
    {
      _phoneSink.addError('Please provide correct 10 digit Phone number');
    }else{
      yield ProfileLoadingState();
     await Firestore.instance.collection("users").document(event.email)
      .updateData({"username":event.displayName,
        "gender": _genderStreamController.value ==0?"Male":"Female",
        "phone": event.phone,
        "dob":event.dob
      });
     if(event.image!=null)
     {
      await uploadProfilePicture(event.image,event.email);
     }
      yield ProfileSuccessState();
    }
       
   }else if(event is ProfileGallerySelected){
    
     SharedPreferences logindata = await SharedPreferences.getInstance();
      logindata.setString("profileimage",event.image.path.toString()); 
    
   

   }
  }

  void handleRadioValueChanged(int value) {
        _genderSink.add(value);
  }

  DateTime SetInitialValueDate() {
    return DateFormat('d-MM-yyyy').parse(dobController.text);
  }
}
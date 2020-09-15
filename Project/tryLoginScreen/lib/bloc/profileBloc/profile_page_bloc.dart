import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
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


final _nameStreamController=BehaviorSubject<String>();
Stream<String> get nameStream => _nameStreamController.stream;
StreamSink<String> get _nameSink => _nameStreamController.sink;
Function(String) get nameChanged => _nameStreamController.sink.add;

    final _genderStreamController=BehaviorSubject<String>();
Stream<String> get genderstream => _genderStreamController.stream;
StreamSink<String> get _genderSink => _genderStreamController.sink;
Function(String) get genderChanged => _genderStreamController.sink.add;

final _imageStreamController=BehaviorSubject<File>();
Stream<File> get imageStream => _imageStreamController.stream;
Function(File) get imageChanged => _imageStreamController.sink.add;


final _dobStreamController=BehaviorSubject<String>();
Stream<String> get dobStream => _dobStreamController.stream;
StreamSink<String> get _dobSink => _dobStreamController.sink;
Function(String) get dobChanged => _dobStreamController.sink.add;

final _phoneStreamController=BehaviorSubject<String>();
Stream<String> get phoneStream => _phoneStreamController.stream;
StreamSink<String> get _phoneSink => _phoneStreamController.sink;
Function(String) get phoneChanged => _phoneStreamController.sink.add;

final _emailStreamController=BehaviorSubject<String>();
Stream<String> get emailStream => _emailStreamController.stream;
StreamSink<String> get _emailSink => _emailStreamController.sink;
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
   //UserModel a=await authRepo.getUser();
   if(event is InitEvent)
   {
     
   String avartarUrl,displayName,gender,dob,phone; 
       


      final results = await Firestore.instance.collection("users").document(user.email).get()
       .then((value)  async {
       print('mmmmmmmmmppppppp:'+value.data["username"]);
       
       displayName=value.data["username"];
       gender=value.data["gender"];       
       dob=value.data["dob"];
       phone=value.data["phone"]; 
     });
      try{
    avartarUrl=await getAvatarUrl(user.email);
      }catch(ex)
      {
        print(ex);
        avartarUrl=null;
      }
    yield ProfileInitialState(avartarUrl:avartarUrl,displayName:displayName ,email: user.email,gender: gender,dob: dob.toString(),phone:phone);
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
     
     await Firestore.instance.collection("users").document(event.email)
      .updateData({"username":event.displayName,
        "gender": event.gender,
        "phone": event.phone,
        "dob":event.dob
      });
      yield ProfileSuccessState();
    }
       
   }else if(event is ProfileGallerySelected){
     await uploadProfilePicture(event.image,event.email);
    
    

   }
  }
}
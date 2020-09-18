import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_event.dart';
import 'package:tryLoginScreen/bloc/homepageBloc/home_page_state.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repository/storage_repo.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final _emailStreamController = BehaviorSubject<String>();
  Stream<String> get emailStream => _emailStreamController.stream;
  StreamSink<String> get _emailSink {
    return _emailStreamController.sink;
  }

  Function(String) get emailChanged => _emailStreamController.sink.add;

  final _imageStreamController = BehaviorSubject<String>();
  Stream<String> get imageStream => _imageStreamController.stream;
  StreamSink<String> get _imageSink {
    return _imageStreamController.sink;
  }

  Function(String) get imageChanged => _imageStreamController.sink.add;

  final _nameStreamController = BehaviorSubject<String>();
  Stream<String> get nameStream => _nameStreamController.stream;
  StreamSink<String> get _nameSink {
    return _nameStreamController.sink;
  }

  Function(String) get nameChanged => _nameStreamController.sink.add;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void setNotification(BuildContext context) {
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("Message:$message");
    }, onResume: (Map<String, dynamic> message) async {
      print("Message:$message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("Message:$message");
    });
  }

  Future<String> getAvatarUrl(String email) async {
    try {
      FirebaseStorage _storage =
          FirebaseStorage(storageBucket: "gs://tryloginscreen.appspot.com");
      return await _storage.ref().child("user/profile/$email").getDownloadURL();
    } catch (ex) {
      return null;
    }

    return null;
  }

  AuthRepo authRepo;
  UserController userController;
  StorageRepo _storageRepo;

  HomePageBloc() : super(LogoutInitialState()) {
    authRepo = AuthRepo();
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = await auth.currentUser();
    if (event is InitEvent) {
      yield HomeLoadingState();
      String initials = "z";
      SharedPreferences logindata = await SharedPreferences.getInstance();
      setNotification(event.context);

      if (logindata.getBool("newsnotification")) {
        await firebaseMessaging.subscribeToTopic('News');
      } else {
        await firebaseMessaging.unsubscribeFromTopic('News');
      }
      if (logindata.getBool("advertisenotification")) {
        await firebaseMessaging.subscribeToTopic('Advertise');
      } else {
        await firebaseMessaging.unsubscribeFromTopic('Advertise');
      }

      String avartarUrl, displayName, gender;

      await Firestore.instance
          .collection("users")
          .document(user.email)
          .get()
          .then((value) async {
        _nameSink.add(value.data["username"]);
        initials = value.data["username"];
        initials = initials[0].toUpperCase();
        _emailSink.add(user.email);

      });
      try {
        avartarUrl = await getAvatarUrl(user.email);
      } catch (ex) {
        print(ex);
        avartarUrl = null;
      }
      _imageSink.add(avartarUrl);
      yield HomeviewInitialState(
          initials: initials,
          avartarUrl: avartarUrl,
          displayName: displayName,
          email: user.email,
          gender: gender);
    } else if (event is LogOutButtonPressedEvent) {
      await authRepo.SignOUt();
      yield LogoutSuccessState();
    }
  }
}

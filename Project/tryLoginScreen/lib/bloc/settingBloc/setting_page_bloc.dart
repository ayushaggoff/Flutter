import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/bloc/settingBloc/setting_page_event.dart';
import 'package:tryLoginScreen/bloc/settingBloc/setting_page_state.dart';

class SettingPageBloc extends Bloc<SettingPageEvent, SettingPageState> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  void setNotification(BuildContext context) {
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("Message:$message");
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              titlePadding: EdgeInsets.all(0),
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${message['notification']['title']}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
          });
    }, onResume: (Map<String, dynamic> message) async {
      print("Message:$message");
    }, onLaunch: (Map<String, dynamic> message) async {
      print("Message:$message");
    });
  }

  SettingPageBloc() : super(SettingLoadingState()) {}
  bool isSwitchedNews;
  bool isSwitchedAvertise;
  @override
  Stream<SettingPageState> mapEventToState(SettingPageEvent event) async* {
    SharedPreferences logindata = await SharedPreferences.getInstance();

    if (event is InitEvent) {
      setNotification(event.context);
      isSwitchedNews = logindata.getBool("newsnotification");
      isSwitchedAvertise = logindata.getBool("advertisenotification");

      yield SettingInitialState(
          isAdvertise: isSwitchedAvertise, isSwitchedNews: isSwitchedNews);
    } else if (event is NewsSetEvent) {
      if (event.isSwitchedNews) {
        logindata.setBool("newsnotification", true);
        isSwitchedNews = true;
        await firebaseMessaging.subscribeToTopic('News');
        logindata.setBool("newsnotification", true);
      } else {
        logindata.setBool("newsnotification", false);
        isSwitchedNews = false;
        await firebaseMessaging.unsubscribeFromTopic('News');
        logindata.setBool("newsnotification", false);
      }
      yield SettingSuccessState();
    } else if (event is AdvertiseSetEvent) {
      if (event.isAdvertiseNews) {
        isSwitchedAvertise = true;
        await firebaseMessaging.subscribeToTopic('Advertise');
        logindata.setBool("advertisenotification", true);
        yield SettingSuccessState();
      } else {
        isSwitchedAvertise = false;
        await firebaseMessaging.unsubscribeFromTopic('Advertise');
        logindata.setBool("advertisenotification", false);
        yield SettingSuccessState();
      }
    }
  }
}

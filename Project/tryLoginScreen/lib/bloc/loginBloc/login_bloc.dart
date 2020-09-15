import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_event.dart';
import 'package:tryLoginScreen/bloc/loginBloc/login_state.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import 'dart:async';
class LoginBloc extends Bloc<LoginEvent,LoginState>{


   AuthRepo authRepo;
   UserController userController;

   
   final _emailStreamController = BehaviorSubject<String>();
   Stream<String> get emailStream => _emailStreamController.stream;
  StreamSink<String> get _emailSink => _emailStreamController.sink;
     Function(String) get emailChanged => _emailStreamController.sink.add;


void dispose(){
  _emailStreamController.close();
}
 LoginBloc() : super(LoginInitialState()){
   authRepo=AuthRepo();
   userController=UserController();
 }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    SharedPreferences logindata;
    logindata=await SharedPreferences.getInstance();
    logindata.setBool("newsnotification",false);
    logindata.setBool("advertisenotification",true);
    

    if(event is LoginButtonPressedEvent){
      try{
        yield LoginLoadingState();
        
        if(_emailStreamController.value?.length<=0)
        {      
           _emailSink.addError('Input is not valid');
        }
        
        await userController.signInWithEmailAndPassword(email:event.email,password:event.password);
        
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }else if(event is FacebookButtonPressedEvent){
       try{
        yield LoginLoadingState();
        await userController.signInWithFacebook();
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }else if(event is GoogleButtonPressedEvent){
       try{
        yield LoginLoadingState();
        await userController.signInWithGoogle();
        yield LoginSuccessfulState();
      }catch(e){
        yield LoginFailureState(message: e.toString());
      }
    }  
  }
}
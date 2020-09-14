import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable{}

class LoginInitialState extends LoginState{
  @override

  List<Object> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginState{
  @override

  List<Object> get props => throw UnimplementedError();
}

class LoginSuccessfulState extends LoginState{
  //FirebaseUser user;
  LoginSuccessfulState();
  @override

  List<Object> get props => throw UnimplementedError();
}

class LoginFailureState extends LoginState{
  String message;
  LoginFailureState({this.message});
  @override

  List<Object> get props => throw UnimplementedError();
}
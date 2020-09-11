import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable{}

class LoginInitialState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginLoadingState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginSuccessfulState extends LoginState{
  //FirebaseUser user;
  LoginSuccessfulState();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginFailureState extends LoginState{
  String message;
  LoginFailureState({this.message});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
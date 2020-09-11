import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tryLoginScreen/model/user_model.dart';

abstract class UserRegState extends Equatable{}

class UserRegInitialState extends UserRegState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserLoadingState extends UserRegState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegSuccessfulState extends UserRegState{
  UserModel usermodel;
  UserRegSuccessfulState();
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserRegFailureState extends UserRegState{
  String message;
  UserRegFailureState({this.message});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
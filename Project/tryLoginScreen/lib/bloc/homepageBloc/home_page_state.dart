import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tryLoginScreen/model/user_model.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';

abstract class HomePageState extends Equatable{}

class LogoutInitialState extends HomePageState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeviewInitialState extends HomePageState{
    String displayName,email,avartarUrl,gender;

  HomeviewInitialState({this.avartarUrl,this.displayName,this.email,this.gender});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class HomeSuccessState extends HomePageState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
class LogoutSuccessState extends HomePageState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
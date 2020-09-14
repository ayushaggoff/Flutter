import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{}

class LoginButtonPressedEvent extends LoginEvent{
  String email,password;


  LoginButtonPressedEvent({this.email,this.password});

  @override
  List<Object> get props => null;
}

class  FacebookButtonPressedEvent extends LoginEvent{
  @override
  List<Object> get props => null;
}

class  GoogleButtonPressedEvent extends LoginEvent{
  @override
  List<Object> get props => null;
}
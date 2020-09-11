import 'package:equatable/equatable.dart';

abstract class UserRegEvent extends Equatable{}

class SignUpButtonPressedEvent extends UserRegEvent{

  String email,password,dob,gender,username,phone;

  SignUpButtonPressedEvent({this.email, this.password,this.dob,this.gender,this.phone,this.username});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
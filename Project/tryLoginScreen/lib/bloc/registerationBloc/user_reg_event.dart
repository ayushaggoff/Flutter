import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserRegEvent extends Equatable {}

class SignUpButtonPressedEvent extends UserRegEvent {
  String email, password, dob, gender, username, phone;

  BuildContext context;

  SignUpButtonPressedEvent(
      {this.context,
      this.email,
      this.password,
      this.dob,
      this.gender,
      this.phone,
      this.username});
  @override
  List<Object> get props => throw UnimplementedError();
}
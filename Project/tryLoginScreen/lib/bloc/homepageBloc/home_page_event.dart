import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomePageEvent extends Equatable{}

class LogOutButtonPressedEvent extends HomePageEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitEvent extends HomePageEvent{
  String displayName,email,avartarUrl,gender;
  BuildContext context;
  InitEvent(this.context);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
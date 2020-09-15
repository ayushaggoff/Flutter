import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ChangePwdPageEvent extends Equatable{}

class ChangePwdButtonPressedEvent extends ChangePwdPageEvent{
 String currentpassword,newpassword,renewpassword;
  ChangePwdButtonPressedEvent({this.currentpassword,this.newpassword,this.renewpassword});
  @override

  List<Object> get props => throw UnimplementedError();
}
class InitEvent extends ChangePwdPageEvent{
  @override
  
  List<Object> get props => throw UnimplementedError();
}

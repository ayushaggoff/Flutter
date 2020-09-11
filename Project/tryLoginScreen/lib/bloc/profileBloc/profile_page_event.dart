import 'package:equatable/equatable.dart';

abstract class ProfilePageEvent extends Equatable{}

class UpdateButtonPressedEvent extends ProfilePageEvent{
  String displayName,email,avartarUrl,gender,dob,phone;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitEvent extends ProfilePageEvent{
  String displayName,email,avartarUrl,gender,dob,phone;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
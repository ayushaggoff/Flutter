import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable{}

class LogOutButtonPressedEvent extends HomePageEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class InitEvent extends HomePageEvent{
  String displayName,email,avartarUrl,gender;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
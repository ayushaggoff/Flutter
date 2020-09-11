import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{}

class AppStartedEvent extends AuthEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

//class SignInWithEmailEvent extends AuthEvent{}

//class SignInWithFacebookEvent extends AuthEvent{}


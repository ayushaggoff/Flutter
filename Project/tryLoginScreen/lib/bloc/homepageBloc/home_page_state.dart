import 'package:equatable/equatable.dart';


abstract class HomePageState extends Equatable{}

class LogoutInitialState extends HomePageState{
  @override

  List<Object> get props => throw UnimplementedError();
}

class HomeviewInitialState extends HomePageState{
    String initials,displayName,email,avartarUrl,gender;

  HomeviewInitialState({this.initials,this.avartarUrl,this.displayName,this.email,this.gender});

  @override

  List<Object> get props => throw UnimplementedError();
}
class HomeSuccessState extends HomePageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
class LogoutSuccessState extends HomePageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
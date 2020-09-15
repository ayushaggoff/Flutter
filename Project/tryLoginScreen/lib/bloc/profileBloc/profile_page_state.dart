import 'package:equatable/equatable.dart';


abstract class ProfilePageState extends Equatable{}


class ProfileInitialState extends ProfilePageState{
    String displayName,email,avartarUrl,gender,dob,phone;
  ProfileInitialState({this.avartarUrl,this.displayName,this.email,this.gender,this.dob,this.phone});
  @override

  List<Object> get props => throw UnimplementedError();
}
class ProfileLoadingState extends ProfilePageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
class ProfileSuccessState extends ProfilePageState{
  @override

  List<Object> get props => throw UnimplementedError();
}
class ProfileFailureState extends ProfilePageState{
 
  String message;
  ProfileFailureState(this.message);
   @override
  List<Object> get props => throw UnimplementedError();
}
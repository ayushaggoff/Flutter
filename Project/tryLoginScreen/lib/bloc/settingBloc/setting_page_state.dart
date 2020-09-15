import 'package:equatable/equatable.dart';


abstract class SettingPageState extends Equatable{}

class SettingInitialState extends SettingPageState{
  bool isSwitchedNews,isAdvertise;
  SettingInitialState({this.isSwitchedNews,this.isAdvertise});
  @override
  List<Object> get props => throw UnimplementedError();
}
class SettingSuccessState extends SettingPageState{
  bool isSwitchedNews,isAdvertise;
  SettingSuccessState({this.isSwitchedNews,this.isAdvertise});
  @override
  List<Object> get props => throw UnimplementedError();
}
class SettingLoadingState extends SettingPageState{
  @override
  List<Object> get props => throw UnimplementedError();
}

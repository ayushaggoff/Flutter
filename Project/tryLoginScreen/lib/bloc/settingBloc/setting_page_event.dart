import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SettingPageEvent extends Equatable{}


class InitEvent extends SettingPageEvent{
  BuildContext context;
  InitEvent(this.context);
  @override
  
  List<Object> get props => throw UnimplementedError();
}

class NewsSetEvent extends SettingPageEvent{
  bool isSwitchedNews;
  NewsSetEvent(this.isSwitchedNews);
  @override

  List<Object> get props => throw UnimplementedError();
}
class AdvertiseSetEvent extends SettingPageEvent{
  bool isAdvertiseNews;
  AdvertiseSetEvent(this.isAdvertiseNews);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
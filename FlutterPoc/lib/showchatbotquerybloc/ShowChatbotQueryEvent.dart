import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ShowChatbotQueryEvent extends Equatable {}

// ignore: must_be_immutable
class InitEvent extends ShowChatbotQueryEvent {
  BuildContext context;
  InitEvent(this.context);
  @override
  List<Object> get props => throw UnimplementedError();
}

class GetUserQueryEvent extends ShowChatbotQueryEvent {

  @override
  List<Object> get props => throw UnimplementedError();
}

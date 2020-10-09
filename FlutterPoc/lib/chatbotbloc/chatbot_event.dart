import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ChatbotPageEvent extends Equatable {}

// ignore: must_be_immutable
class InitEvent extends ChatbotPageEvent {
  BuildContext context;
  InitEvent(this.context);
  @override
  List<Object> get props => throw UnimplementedError();
}
class ExploreTechSolnEvent extends ChatbotPageEvent {

  @override
  List<Object> get props => throw UnimplementedError();
}

class JobQueryEvent extends ChatbotPageEvent {

  @override
  List<Object> get props => throw UnimplementedError();
}


class OtherEnquiryEvent extends ChatbotPageEvent {

  @override
  List<Object> get props => throw UnimplementedError();
}


class MessageEvent extends ChatbotPageEvent {

  @override
  List<Object> get props => throw UnimplementedError();
}

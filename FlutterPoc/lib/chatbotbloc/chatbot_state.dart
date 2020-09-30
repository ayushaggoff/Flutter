import 'package:equatable/equatable.dart';

abstract class ChatbotPageState extends Equatable {}

class ChatbotInitialState extends ChatbotPageState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChatbotSuccessState extends ChatbotPageState {
    List<Map> messsages = List();
ChatbotSuccessState({this.messsages});
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChatbotLoadingState extends ChatbotPageState {
  @override
  List<Object> get props => throw UnimplementedError();
}

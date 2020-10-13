
import 'package:equatable/equatable.dart';

abstract class ShowChatbotQueryState extends Equatable {}

class ShowChatbotQueryInitialState extends ShowChatbotQueryState {
  @override
  List<Object> get props => null;
}

class ShowChatbotQuerySuccessState extends ShowChatbotQueryState {
  @override
  List<Object> get props => null;
}

class ShowChatbotQueryLoadingState extends ShowChatbotQueryState {
  @override
  List<Object> get props => throw UnimplementedError();
}
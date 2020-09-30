import 'dart:async';

import 'package:FlutterPoc/chatbotbloc/chatbot_evet.dart';
import 'package:FlutterPoc/chatbotbloc/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:rxdart/rxdart.dart';

class ChatbotBloc extends Bloc<ChatbotPageEvent, ChatbotPageState> {
  ChatbotBloc(initialState) : super(ChatbotSuccessState());
  List<Map> messsages = List();
     final messageController = TextEditingController();

  final _messageStreamController = BehaviorSubject<String>();
  Stream<String> get messageStream => _messageStreamController.stream;
  StreamSink<String> get _messageSink {
    return _messageStreamController.sink;
  }
  Function(String) get messageChanged => _messageStreamController.sink.add;

 final _listStreamController = BehaviorSubject<List<Map>>();
  Stream<List<Map>> get listStream => _listStreamController.stream;
  StreamSink<List<Map>> get _listSink {
    return _listStreamController.sink;
  }
  Function(List<Map>) get listChanged => _listStreamController.sink.add;

    void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/service.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
     await messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
   }

  @override
  Stream<ChatbotPageState> mapEventToState(ChatbotPageEvent event) async*{
    
    if(event is MessageEvent)
    {
      if(messageController.text.isNotEmpty)
      {
      await messsages.insert(0,{"data": 1, "message": messageController.text});
      await response(messageController.text);
      _listStreamController.value=messsages;
      messageController.text="";
      }else{
           // await messsages.insert(3,{"data": 0, "message": "Please provide the input"});

      }
    }
  }


}
import 'dart:async';
import 'package:FlutterPoc/chatbotbloc/chatbot_event.dart';
import 'package:FlutterPoc/chatbotbloc/chatbot_state.dart';
import 'package:FlutterPoc/model/chatbotmodel.dart';
import 'package:FlutterPoc/repo/FirebaseRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '../view/Chatbotpage.dart';

class ChatbotBloc extends Bloc<ChatbotPageEvent, ChatbotPageState> {
ChatbotModel chatbotModel=ChatbotModel();
  ChatbotBloc(initialState) : super(ChatbotSuccessState());
  FirebaseRepo firebaseRepo=FirebaseRepo();
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

  final _checkChatEndedStreamController = BehaviorSubject<bool>();
  Stream<bool> get checkChatEndedStream => _checkChatEndedStreamController.stream;
  StreamSink<bool> get _checkChatEndedSink {
    return _checkChatEndedStreamController.sink;
  }  
  Function(bool) get checkChatEndedChanged => _checkChatEndedStreamController.sink.add;

    void response(query) async {
    AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/service.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);

    AIResponse aiResponse = await dialogflow.detectIntent(query);

      
    print(aiResponse.getListMessage().toString());
     await messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
      _listStreamController.value=messsages;
      
      switch(aiResponse.queryResult.parameters.keys.toString())
      {
        case "(typeofquery)":
          chatbotModel.querytype=aiResponse.queryResult.parameters["typeofquery"].toString(); 
        break;
        case "(techsolnEntity)":
          chatbotModel.querytype="Explore Tech Solution"; 
        break;
        case"(Otherenquiryentity)":
        chatbotModel.querytype=aiResponse.queryResult.parameters["Otherenquiryentity"].toString(); 
        break;
        case"(any)":
          chatbotModel.query=aiResponse.queryResult.parameters["any"].toString(); 
        break;
        case "(name)":
          chatbotModel.name=aiResponse.queryResult.parameters["name"].toString();       
        break;
        case "(email)":
         chatbotModel.responseId=aiResponse.responseId;
         chatbotModel.email=aiResponse.queryResult.parameters["email"];
         firebaseRepo.setData(chatbotModel);
       
    _checkChatEndedStreamController.value=false;                
      break;
    }
    print(aiResponse.queryResult.parameters.keys.toString());
    print( aiResponse.responseId);  
    print(aiResponse.queryResult.parameters.toString());
    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    }

  @override
  Stream<ChatbotPageState> mapEventToState(ChatbotPageEvent event) async*{
    if(event is InitEvent){
      _checkChatEndedStreamController.value=true;
      yield ChatbotLoadingState();
    messsages.insert(0,{"data": 3,"message":"" });
    _listStreamController.value=messsages;

yield ChatbotSuccessState();
    }else  if(event is MessageEvent)
    {

      if(messageController.text.isNotEmpty)
      {
       messsages.insert(0,{"data": 1, "message": messageController.text});
       response(messageController.text);
       _listStreamController.value=messsages;
      messageController.text="";
      }else{

      }
    }else if(event is ExploreTechSolnEvent){ 
      
      messsages.insert(0,{"data": 1,"message":"Explore Tech Solution" });
      _listStreamController.value=messsages;  
      _messageStreamController.value="";
      response("tech solution");
      _listStreamController.value=messsages;  

    }else if(event is JobQueryEvent){
      
      messsages.insert(0,{"data": 1,"message":"Job Query" });
      _messageStreamController.value="";
      response("job");
      _listStreamController.value=messsages;  
 
    }else if(event is OtherEnquiryEvent){

      messsages.insert(0,{"data": 1,"message":"other Enquiry" });
      _messageStreamController.value="";
      response("enquiries");
      _listStreamController.value=messsages;  
 
    }
  }

 void chatbotResetReset(BuildContext context){
     Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ChatbotPage()));
 }

  void dispose() {
  _messageStreamController.close();
  _listStreamController.close();
}
}
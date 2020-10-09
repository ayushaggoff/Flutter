import 'dart:async';
import 'package:FlutterPoc/chatbotbloc/chatbot_event.dart';
import 'package:FlutterPoc/chatbotbloc/chatbot_state.dart';
import 'package:FlutterPoc/model/chatbotmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ChatbotBloc extends Bloc<ChatbotPageEvent, ChatbotPageState> {
ChatbotModel chatbotModel=ChatbotModel();
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
  // print(aiResponse.webhookStatus.message);
    print(aiResponse.getListMessage().toString());
     await messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
      
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
        case"(userQuery)":
          chatbotModel.query=aiResponse.queryResult.parameters["userQuery"].toString(); 
        break;
        case "(name)":
          chatbotModel.name=aiResponse.queryResult.parameters["name"].toString();       
        break;
        case "(email)":
        FirebaseFirestore.instance.collection("collectionPath").doc(aiResponse.responseId).set({
          "responseId":aiResponse.responseId,
           "date":"${DateFormat("yMd").format(DateTime.now())}",
           "name": chatbotModel.name,
           "email": aiResponse.queryResult.parameters["email"],
           "query type":chatbotModel.querytype,
          "query": chatbotModel.query,
          });

            messsages.insert(0,{"data": 3, "message": "Your chat has ended."});       
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
      print("console");
    //sresponse("tech solution");
      messsages.insert(0,{"data": 1,"message":"Explore Tech Solution" });
      _listStreamController.value=messsages;  
      _messageStreamController.value="";
      response("tech solution");
      print("last console");

    }else if(event is JobQueryEvent){
        messsages.insert(0,{"data": 1,"message":"Job Query" });
      _listStreamController.value=messsages; 
    }else if(event is OtherEnquiryEvent){
      messsages.insert(0,{"data": 1,"message":"other Enquiry" });
      _listStreamController.value=messsages; 
    }
  }

 Future btnExploreTechSoln(){
print("console");
//sresponse("tech solution");
  messsages.insert(0,{"data": 1,"message":"Explore Tech Solution" });
 _listStreamController.value=messsages;  
print("last console");

 }

  void dispose() {
  _messageStreamController.close();
  _listStreamController.close();
}
}
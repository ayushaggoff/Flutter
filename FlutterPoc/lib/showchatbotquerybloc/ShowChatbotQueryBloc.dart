import 'dart:async';
import 'dart:io';
import 'package:FlutterPoc/repo/FirebaseRepo.dart';
import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryEvent.dart';
import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ShowChatbotQueryBloc extends Bloc<ShowChatbotQueryEvent, ShowChatbotQueryState> {
  
  ShowChatbotQueryBloc(initialState) : super(ShowChatbotQuerySuccessState());
  FirebaseRepo firebaseRepo=FirebaseRepo();
  List<DocumentSnapshot> documentList;
  BehaviorSubject<List<DataRow>> chatbotController= BehaviorSubject<List<DataRow>>();
  Stream<List<DataRow>> get chatbotStream => chatbotController.stream;

// Future<List<DataRow>> _createRows() async {

//     List<DataRow> newList = (await FirebaseFirestore.instance
//             .collection("Query").orderBy("date")

//             .get()).docs.map((DocumentSnapshot documentSnapshot) {
//       return new DataRow(cells: <DataCell>[
//           DataCell(Text(documentSnapshot["date"])),
//                         DataCell(Text(documentSnapshot["name"])),
//                         DataCell(Text(documentSnapshot["email"])),
//                         DataCell(Text(documentSnapshot["query type"].toString())),
//                         DataCell(Text(documentSnapshot["query"].toString()))
//                ]);
//     }).toList();

//     return newList;
//   }

  

@override
  Stream<ShowChatbotQueryState> mapEventToState(ShowChatbotQueryEvent event) async*{
    if(event is InitEvent){
    
    try {
      //List<DataRow> listQuery=await _createRows();
      List<DataRow> listQuery=await firebaseRepo.getdataCreateRows();
      chatbotController.sink.add(listQuery);
      try {
        if (listQuery.length == 0) {
          chatbotController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      chatbotController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      chatbotController.sink.addError(e);
    }
  yield ShowChatbotQuerySuccessState();
    }
  }

  void dispose() {
    chatbotController.close();
  }


}
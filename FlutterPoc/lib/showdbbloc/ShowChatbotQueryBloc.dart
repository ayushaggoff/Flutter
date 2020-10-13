import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ShowChatbotQueryBloc {
  
  bool showIndicator = false;
  List<DocumentSnapshot> documentList;
  BehaviorSubject<List<DataRow>> chatbotController;

  BehaviorSubject<bool> showIndicatorController;

  ShowChatbotQueryBloc() {
    chatbotController = BehaviorSubject<List<DataRow>>();
    showIndicatorController = BehaviorSubject<bool>();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;
  Stream<List<DataRow>> get chatbotStream => chatbotController.stream;


Future<List<DataRow>> _createRows() async {

    List<DataRow> newList = (await Firestore.instance
            .collection("Query")
            .getDocuments()).documents.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: <DataCell>[
          DataCell(Text(documentSnapshot["date"])),
                        DataCell(Text(documentSnapshot["name"])),
                        DataCell(Text(documentSnapshot["email"])),
                        DataCell(Text(documentSnapshot["query type"].toString())),
                        DataCell(Text(documentSnapshot["query"]))
               ]);
    }).toList();

    return newList;
  }

  Future fetchFirstList() async {
    try {
      List<DataRow> listQuery=await _createRows();
      chatbotController.sink.add(listQuery);
      try {
        if (documentList.length == 0) {
          chatbotController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      chatbotController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      chatbotController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  // fetchNextMovies() async {
  //   try {
  //     updateIndicator(true);
  //     List<DocumentSnapshot> newDocumentList =
  //         await firebaseProvider.fetchNextList(documentList);
  //     documentList.addAll(newDocumentList);
  //     movieController.sink.add(documentList);
  //     try {
  //       if (documentList.length == 0) {
  //         movieController.sink.addError("No Data Available");
  //         updateIndicator(false);
  //       }
  //     } catch (e) {
  //       updateIndicator(false);
  //     }
  //   } on SocketException {
  //     movieController.sink.addError(SocketException("No Internet Connection"));
  //     updateIndicator(false);
  //   } catch (e) {
  //     updateIndicator(false);
  //     print(e.toString());
  //     movieController.sink.addError(e);
  //   }
  // }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    chatbotController.close();
    showIndicatorController.close();
  }
}
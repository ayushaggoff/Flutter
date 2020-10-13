import 'package:FlutterPoc/model/chatbotmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class FirebaseRepo{
Future<List<DataRow>> getdataCreateRows() async {

    List<DataRow> newList = (await FirebaseFirestore.instance
            .collection("Query").orderBy("date")
            .get()).docs.map((DocumentSnapshot documentSnapshot) {
      return new DataRow(cells: <DataCell>[
          DataCell(Text(documentSnapshot["date"])),
                        DataCell(Text(documentSnapshot["name"])),
                        DataCell(Text(documentSnapshot["email"])),
                        DataCell(Text(documentSnapshot["query type"].toString())),
                        DataCell(Text(documentSnapshot["query"].toString()))
               ]);
    }).toList();
    return newList;
  }
  void setData(ChatbotModel chatbotModel){
    FirebaseFirestore.instance.collection("Query").doc(chatbotModel.responseId).set({
          "responseId":chatbotModel.responseId,
           "date":"${DateFormat("yMd").format(DateTime.now())}",
           "name": chatbotModel.name,
           "email": chatbotModel.email,
           "query type":chatbotModel.querytype,
          "query": chatbotModel.query,
          });
  }
}
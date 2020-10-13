import 'package:FlutterPoc/showdbbloc/ShowChatbotQueryBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShowChatbotQueryBloc chatbotBloc;
 
  ScrollController controller = ScrollController();

  @override
  void initState() {
    
    super.initState();
    chatbotBloc = ShowChatbotQueryBloc();
    chatbotBloc.fetchFirstList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot User Query"),),
      body: StreamBuilder<List<DataRow>>(
        stream: chatbotBloc.chatbotStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              child: DataTable(columns: [ 
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Query type')),
                DataColumn(label: Text('Query')),
              ], rows:snapshot.data
              ),
            ); 
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
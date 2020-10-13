import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryBloc.dart';
import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryEvent.dart';
import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShowChatbotQueryBloc chatbotBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowChatbotQueryBloc>(
      create: (context) => ShowChatbotQueryBloc(ShowChatbotQuerySuccessState)..add(InitEvent(context)),
      child:
    BlocBuilder<ShowChatbotQueryBloc, ShowChatbotQueryState>(
      builder: (BuildContext context, ShowChatbotQueryState state) {
        if (state is ShowChatbotQueryInitialState) {
          return Center(child: CircularProgressIndicator());
        }
    else if(state is ShowChatbotQuerySuccessState){
         
             chatbotBloc = BlocProvider.of<ShowChatbotQueryBloc>(context);
          return Scaffold( 
      appBar: AppBar(title: Text("Chatbot User Query"),),
      body: StreamBuilder<List<DataRow>>(
        stream: BlocProvider.of<ShowChatbotQueryBloc>(context).chatbotStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return  SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              child: DataTable(columns: [ 
                DataColumn(label: Text('Date',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Name',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Email',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Query type',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                DataColumn(label: Text('Query',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
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
    ),
    );
  }
}
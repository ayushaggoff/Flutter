import 'package:FlutterPoc/showchatbotquerybloc/ShowChatbotQueryBloc.dart';
import 'package:flutter/material.dart';

import '../EnquiryDataSource .dart';

class TryView extends StatefulWidget {
  @override
  _TryViewState createState() => _TryViewState();
}

class _TryViewState extends State<TryView> {
 ShowChatbotQueryBloc chatbotBloc;
 
  ScrollController controller = ScrollController();

  @override
  void initState() {
    
    super.initState();
    //chatbotBloc = ShowChatbotQueryBloc();
   // chatbotBloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase firestore pagination"),),
      // body: StreamBuilder<List<DataRow>>(
      //   stream: chatbotBloc.chatbotStream,
      //   builder: (context, snapshot) {
      //     if (snapshot.data != null) {
      //       return  SingleChildScrollView(
      //         child: PaginatedDataTable (
      //           header: Text("lol"),
      //           source: EnquiryDataSource(widget.c),
      //           columns: [ 
      //           DataColumn(label: Text('Date')),
      //           DataColumn(label: Text('Name')),
      //           DataColumn(label: Text('Email')),
      //           DataColumn(label: Text('Query type')),
      //           DataColumn(label: Text('Query')),
      //         ],
      //         //rows:snapshot.data
      //         // [ 
      //         //   DataRow(cells: <DataCell>[
      //         //             DataCell(Text(snapshot.data[0]["name"])),
      //         //             DataCell(Text(snapshot.data[0]["email"]))
      //         //    ] )
      //         ),
      //       ); 
            
      //       // return ListView.builder(
      //       //  itemCount: snapshot.data.length,
      //       //  shrinkWrap: true,
      //       //  controller: controller,
      //       //  itemBuilder: (context, index) {
      //       //     return Card(
      //       //       child: Padding(
      //       //         padding: const EdgeInsets.all(8.0),
      //       //         child: 
      //       //               Text(snapshot.data[index]["name"].toString()),
                    
      //       //       ),
      //       //     );
      //       //  },
      //       // );
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   },
      // ),
    );
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
 
    }
  }


}
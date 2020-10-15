import 'package:FlutterPoc/chatbotbloc/chatbot_bloc.dart';
import 'package:FlutterPoc/chatbotbloc/chatbot_event.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../chatbotbloc/chatbot_state.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
    final messageInsert = TextEditingController();
    ChatbotBloc bloc;    
    bool ended=true;
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider<ChatbotBloc>(
      create: (context) => ChatbotBloc(ChatbotSuccessState )..add(InitEvent(context)),
      child:
    BlocBuilder<ChatbotBloc, ChatbotPageState>(
      builder: (BuildContext context, ChatbotPageState state) {
        if (state is ChatbotInitialState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ChatbotLoadingState) {
          
            return Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is ChatbotSuccessState){
         
             bloc = BlocProvider.of<ChatbotBloc>(context);
          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Help"),
        ),
        body:Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text("Today, ${DateFormat("yMd").format(DateTime.now())}", style: TextStyle(
                fontSize: 20
              ),),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Text("${DateFormat("jm").format(DateTime.now())}", style: TextStyle(
                fontSize: 16,
                color: Colors.grey
              ),),
            ),
            Flexible(
                child: StreamBuilder<List<Map>>(
                  stream: bloc.listStream,
                  builder: (context, snapshot) {

                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data==null?0:snapshot.data.length,
                        itemBuilder: (context, index) => chat(
                        snapshot.data[index]["message"].toString(),
                        snapshot.data[index]["data"],context));
                  }
                )
              ),
            SizedBox(
              height: 20,
            ),

            Divider(
              height: 5.0,
              color: Colors.greenAccent,
            ),
            StreamBuilder<bool>(
              stream: BlocProvider.of<ChatbotBloc>(context).checkChatEndedStream,
              builder: (context, snapshot) {
                return ended==snapshot.data?
                Container(
                  child: ListTile(
                      title: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              15)),
                          color: Color.fromRGBO(220, 220, 220, 1),
                        ),
                        padding: EdgeInsets.only(left: 15),
                        child: StreamBuilder<String>(
                          stream:  BlocProvider.of<ChatbotBloc>(context).messageStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: bloc.messageController,
                              enabled: snapshot.hasData,
                              decoration: InputDecoration(
                                hintText: "Enter a Message...",
                                hintStyle: TextStyle(
                                    color: Colors.black26
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),

                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),
                              onChanged: (value) {

                              },
                            );
                          }
                        ),
                      ),

                      trailing: IconButton(

                          icon: Icon(

                            Icons.send,
                            size: 30.0,
                            color: Colors.greenAccent,
                          ),
                          onPressed: () async {

                           BlocProvider.of<ChatbotBloc>(context).add(MessageEvent());
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            setState(() {
                              
                            });
                       }
                     ),

                  ),

                )
                :Container(
                  child: Center(child:Column(
                    children: [
                      Text("Your chat has ended.",style: TextStyle(color: Colors.black, fontSize: 16),),
                      FlatButton(child: Text("To start a new chat, click here.",
                      style: TextStyle(color: Colors.red, fontSize: 16,decoration: TextDecoration.underline),), 
                      onPressed: (){
                        bloc.chatbotResetReset(context);
                      },),
                    ],
                  ) ),
                );
              }
            ),
            
            
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
        }
      }
    )
    );
  }

}
Widget chat(String message, int data,BuildContext context) {
     // ChatbotBloc bloc=ChatbotBloc(ChatbotInitialState);  
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
          mainAxisAlignment: data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            data == 0 || data ==3? Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
               child:Image.asset("images/logo_successive_short_1.png") ,
              ),
            ) : Container(),
        Padding(
        padding: EdgeInsets.all(10.0),
        child: Bubble(
            radius: Radius.circular(15.0),
            color: data == 0||data==3 ? Colors.deepOrange: Colors.blueGrey,
            elevation: 0.0,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  data==0||data==1?
                  Flexible(
                      child: Container(
                        constraints: BoxConstraints( maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                      ):
                     Flexible(
                      child:
               Container(
                 constraints: BoxConstraints( maxWidth: 200),
                 child: Column(
                   
                  children: [
                    Text("Hello, welcome to Successive Technologies. Please reach out to find answers to your queries",
                    style: TextStyle(color: Colors.white,fontSize: 16),),
                    FlatButton(
                      onPressed:(){
                        BlocProvider.of<ChatbotBloc>(context).add(ExploreTechSolnEvent()); 
                        
                      } ,
                      child: Text("Explore Tech Solution",
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)
                      ),
                    ),
                    FlatButton(
                      onPressed:()async{
                       BlocProvider.of<ChatbotBloc>(context).add(JobQueryEvent()); 
                      } ,
                      child: Text("Job Query",
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)
                      ),
                    ),
                    FlatButton(
                      onPressed:(){
                        BlocProvider.of<ChatbotBloc>(context).add(OtherEnquiryEvent());
                      } ,
                      child: Text("Other Enquiry",
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.underline,)
                      ),
                    ),
                  ],
              
            ),
               ),
                     ) ,

                ],
              ),
            )),
      ),
            data == 1? Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child:Image.asset("images/user.png",) ,
              ),
            ) : Container(),
            
          ],
        ),
    );
  }

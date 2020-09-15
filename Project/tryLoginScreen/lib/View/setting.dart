import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/bloc/settingBloc/setting_page_bloc.dart';
import 'package:tryLoginScreen/bloc/settingBloc/setting_page_event.dart';
import 'package:tryLoginScreen/bloc/settingBloc/setting_page_state.dart';
class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  SharedPreferences logindata;
  bool isSwitchedNews=true ;
    bool isSwitchedAvertise=true;

  
@override
  void initState() {

   getdata();
  }

   getdata() async{
     print('//////////////////////// setting     getdaTa  method');
    logindata = await SharedPreferences.getInstance();
    setState(() {
    isSwitchedNews = logindata.getBool("newsnotification");   
    isSwitchedAvertise=logindata.getBool("advertisenotification");
    });
    //isSwitchedNews = logindata.getBool("newsnotification");
    //isSwitchedAvertise=logindata.getBool("advertisenotification");
    print('//////////////////////// setting     getdaTa isswitchednews:'+isSwitchedNews.toString());
  }
  
  
 FirebaseMessaging firebaseMessaging =  FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
 //getdata();
    return 
    SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Setting",
          style: TextStyle(color:Colors.white,),
          )
          ),
        body:
        BlocProvider<SettingPageBloc>(
        create: (context) => SettingPageBloc()..add(InitEvent()),
          child: BlocListener<SettingPageBloc,SettingPageState>(
                        listener: (context,state)
                        {
                          if(state is SettingSuccessState){
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SettingView()),
                       );
                          }
                        },
                          child: 
          BlocBuilder<SettingPageBloc, SettingPageState>(
              builder: (context, state) {

            if (state is SettingInitialState) {
              isSwitchedNews=state.isSwitchedNews;
              isSwitchedAvertise=state.isAdvertise;
            return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors:[
                  Colors.blue[300],
                  Colors.blue[600],
                  Colors.blue[300]
                ]
              ),
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text('Notification',
               style: TextStyle(
                  color: Colors.white,
                   fontSize: 34,
               ),
               ),
                ),
               
               
                     Container(
                        padding: EdgeInsets.all(30.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
        width: 0, color: Colors.white),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60),)   
                        ),
                       
              ),

                    Expanded(
                      
                        child: Container( 
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                                   Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                       
    Card(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)) ),
      shadowColor:Colors.blue,
        elevation: 10,
        color: Colors.white,                              
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
                children: [                            
                  Row(
                  mainAxisAlignment:   MainAxisAlignment.spaceBetween,
                  children: [
                  Text('News',
                  style: TextStyle(
                  fontSize: 18,color: Colors.black),
                  ),
                  Switch(focusColor: Colors.blue[300],
                  hoverColor:Colors.blue,
                   value: isSwitchedNews,
              onChanged: (value)async{
                if(isSwitchedNews==true)
                  {

                   BlocProvider.of<SettingPageBloc>(context).add(NewsSetEvent(false));
                            print('unsubscribe news');
                              
                            
                  }else{
                    BlocProvider.of<SettingPageBloc>(context).add(NewsSetEvent(true));
                            print('subscribe news');
                         
                            
                  }
                setState(() {
                  isSwitchedNews=value;
                  print(isSwitchedNews);
                 
                });
              }
                  )
                ],),
                              Divider(
              color: Colors.blueGrey
            ),                
 Row(
                                                   mainAxisAlignment:   MainAxisAlignment.spaceBetween,
                                                   children: [
                            Text('Advertisement',
                            style: TextStyle(
                            fontSize: 18, color: Colors.black),
                            ),
                            Switch(focusColor: Colors.blue[200],
                            hoverColor:Colors.blue,
                             value: isSwitchedAvertise,
              onChanged: (value)async{
                  if(isSwitchedAvertise==true)
                            {
                              BlocProvider.of<SettingPageBloc>(context).add(AdvertiseSetEvent(false));
                              print('unsubscribe Advertisement');
                            }else{
                              BlocProvider.of<SettingPageBloc>(context).add(AdvertiseSetEvent(true));
                              print('subscribe Advertisement');
                            }
                  setState(() {
                            isSwitchedAvertise=value;
                            print(isSwitchedAvertise);
                   
                  });
              }
                            )
                  ],),
                
                                                
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                      
                ]  ),
                          ),
                        ),
                      ),
                    
         

//
               ] ), 
        

      );
   }
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          })),
    )
      
      )
     );
  }
}
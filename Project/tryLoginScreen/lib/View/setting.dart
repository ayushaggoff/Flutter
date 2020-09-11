import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void setNotification()
  {
  //  getdata();
   
   firebaseMessaging.configure(
     onMessage: (Map<String,dynamic>message) async{
          print("Message:$message");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(  
                                     shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      titlePadding: EdgeInsets.all(0),
                                      title: Container(
                                      //  color: Colors.blue[300],
                                        decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0,right:8.0),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children:[Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('${message['notification']['title']}',style: TextStyle(color:Colors.white),),
                                          ),
                                         
            ],),
                                        ),
                                      ),  
                                      content: Text('${message['notification']['body']}'),  
                                      actions: [  
                                        FlatButton(  
                                          child: Text("OK"),  
                                          onPressed: () {  
                                            Navigator.of(context).pop();  
                                         
                                          },  
                                        ),  
                                      ],  
                                    ); 
           });
        },
        onResume: (Map<String,dynamic>message) async{
          print("Message:$message");
        },
        onLaunch: (Map<String,dynamic>message) async{
          print("Message:$message");
        }
    );

  }
  @override
  Widget build(BuildContext context) {
   
    
    setNotification();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Setting",
          style: TextStyle(color:Colors.white,),
          )
          ),
        body:Container(
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
                    
                
            

/////////////////////pppppppppppppppppppppreeeeeeeeeeeeeeecvvvvvvvvvvvvvvvvvvvvv
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
                    logindata.setBool("newsnotification",false);
                            print('unsubscribe news');
                            await firebaseMessaging.unsubscribeFromTopic('News');
                  }else{
                    logindata.setBool("newsnotification",true);
                            print('subscribe news');
                            await firebaseMessaging.subscribeToTopic('News');
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
                               logindata.setBool("advertisenotification",false);
                              print('unsubscribe Advertisement');
                              await firebaseMessaging.unsubscribeFromTopic('Advertise');
                            }else{
                               logindata.setBool("advertisenotification",true);
                              print('subscribe Advertisement');
                              await firebaseMessaging.subscribeToTopic('Advertise');
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
        
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Column(
        //     children: [
        //       Text('Notification',
        //       style: TextStyle(
        //         fontSize: 24,
        //       ),textAlign: TextAlign.left,
        //       ),
        //       Row(children: [
        //         Text('News',
        //         style: TextStyle(
        //         fontSize: 18),
        //         ),
        //         Switch(focusColor: Colors.blue[300],
        //         hoverColor:Colors.blue,
        //          value: isSwitched,
        //     onChanged: (value)async{
        //       if(isSwitched==true)
        //         {
        //           print('subscribe news');
        //           await firebaseMessaging.unsubscribeFromTopic('News');
        //         }else{
        //           print('unsubscribe news');
        //           await firebaseMessaging.subscribeToTopic('News');
        //         }
        //       setState(() {
        //         isSwitched=value;
        //         print(isSwitched);
               
        //       });
        //     }
        //         )
        //       ],)
        //     ],
        //   ),
        // ),

      )
       )   );
  }
}
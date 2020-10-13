import 'package:FlutterPoc/view/Chatbotpage.dart';
import 'package:FlutterPoc/view/showchatbotquery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Flutter POC',
            ),
            RaisedButton(
              color: Colors.blue[100],
            hoverColor: Colors.blue,
              highlightColor: Colors.blue[300],
              onPressed: (){
                  Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => HomePage()));

            }, child: Text("Chatbot User Query"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => ChatbotPage()));
        },        
        child: Icon(Icons.question_answer),
      ), 
    );
  }
}

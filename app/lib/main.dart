import './result.dart';
import 'package:flutter/material.dart';
import './quiz.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     // TODO: implement createState
     return MyAppState();
   }
 }

 class MyAppState extends State<MyApp>
 {
  var questionIndex=0;
 var questions=[
      {
        'questionText':'What\'s your fav color',
        'answers':[{'text':'Black','score':10},{'text':'Red','score':2},{'text':'Green','score':2},{'text':'white','score':0}]
      },
      {
        'questionText':'What\'s your fav pet',
        'answers':[{'text':'Rabbit','score':10},{'text':'Dog','score':10},{'text':'Snake','score':10},{'text':'Lion','score':0}]
      },
      {
        'questionText':'Who\'s your fav instructor',
        'answers':[{'text':'Ayush','score':10},{'text':'Ayush','score':2},{'text':'Ayush','score':10},{'text':'Ayush','score':9}]
      }
    ];
  
  int totalScore=0;
void resetQuiz(){
  setState(() {
    questionIndex=0;
    totalScore=0;
  });
}

  void answerQuestion(int score)
  {
    totalScore+=score;
      setState(() {
      questionIndex=questionIndex+1;
      });
            print(questionIndex);

  }
   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     
    
  return MaterialApp(home: Scaffold(
    appBar: AppBar(title: Text("My first app"),
    ),
    body:(questionIndex<questions.length)
    ?Quiz(questions,answerQuestion,questionIndex)
    :Result(totalScore,resetQuiz),
    ),
  );
  }
}
 
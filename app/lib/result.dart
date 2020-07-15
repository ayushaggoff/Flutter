import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
final Function resetHandler;
Result(this.resultScore,this.resetHandler);
String get resultPhrase
{
  var resultText='You did it';
  if(resultScore<=10)
  {
    resultText='You are bad';
  }else if(resultScore<=20)
  {
    resultText='You are Less bad';
  }else 
  {
    resultText='You are not bad enough';
  }
  return resultText;
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
              children:<Widget>[ Text(
          resultPhrase,
    style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),
    ),
 FlatButton(
   child:Text('Restart Quiz!',),
    onPressed: resetHandler,
    textColor: Colors.blue,
    ),
          ],
      ),
    );
  }
}
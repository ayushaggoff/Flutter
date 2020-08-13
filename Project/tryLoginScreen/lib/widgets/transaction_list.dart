import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transaction;

TransactionList(this.transaction);
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      child: transaction.isEmpty?
      Column(
        children:<Widget> [
        Text(
          'No Transaction Added',
          style: Theme.of(context).textTheme.title,
        ),
        Container(
          height: 200,
          child: Image.asset('assests/images/waiting.png',fit: BoxFit.cover,
          ),
        ),
        ],
      ) :ListView.builder(
        itemBuilder: (ctx,index){
return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical:10,
                      horizontal:15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:Colors.purple,
                        width:2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(transaction[index].amount.toString(),
                  style: TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize:20,
                    color:Colors.purple,
                  ),
                  ),
                ),
                Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                Text(transaction[index].title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ) ,
                ),
                Text(
                  DateFormat.yMMMEd().format(transaction[index].date),
                  style: TextStyle(
                  color: Colors.grey,
                ) ,
                ),
                ],),
                ],
              ),
            );

        },
        itemCount: transaction.length,
        ),
    );
  }
}
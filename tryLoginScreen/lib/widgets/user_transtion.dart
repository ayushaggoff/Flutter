import '../model/transaction.dart';
import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransanction extends StatefulWidget {
  @override
  _UserTransanctionState createState() => _UserTransanctionState();
}

class _UserTransanctionState extends State<UserTransanction> {
  
final List<Transaction> userTransaction=[
    // Transaction(
    //   id:'t1',
    //   title: 'Shoes',
    //   amount: 1999.9,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id:'t2',
    //   title: 'Groceries',
    //   amount: 2909,
    //   date: DateTime.now(),
    // )
  ];

  void _addNewTransaction(String txtitle, double txAmount)
  {
    final newTx=Transaction(
      title:txtitle,
      amount:txAmount,
      date:DateTime.now(),
      id:DateTime.now().toString(),
    );

    setState(()
    {
      userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
      NewTransaction(_addNewTransaction),
      TransactionList(userTransaction)  
      ],
    );
  }
}
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/styleSheet.dart';
import 'package:outlook/ui_components/listCardTransactionHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countup/countup.dart';

class TransactionList extends StatefulWidget {
  final String filter;

  const TransactionList({Key key, this.filter});
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  String id;
  bool loading;

  @override
  void initState() {
    loading = true;
    getId();
  }

  Future<void> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('userID');
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //getId();
    return loading
        ? Text('loading')
        : StreamBuilder<QuerySnapshot>(
            stream:
                transactionHistory.where('userID', isEqualTo: id).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data.docs.isEmpty) {
                return Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 85,
                    ),
                    Icon(
                      Icons.app_blocking,
                      color: Colors.grey,
                      size: 35.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'You have not made any transaction',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ));
              }

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  print('docs here');
                  //print(document.reference.id);
                  print(document.data());
                  return new ListCard(
                    filter: widget.filter,
                    date: document.data()['date'],
                    amount: document.data()['amount'],
                    type: document.data()['type'],
                    typeDetails: document.data()['method'],
                  );
                }).toList(),
              );
            },
          );
  }
}

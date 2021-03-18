import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/ui_components/allInvestmentsHistoryListCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestmentsHistoryList extends StatefulWidget {
  @override
  _InvestmentsHistoryListState createState() => _InvestmentsHistoryListState();
}

class _InvestmentsHistoryListState extends State<InvestmentsHistoryList> {
  String id;
  bool loading;

  @override
  void initState() {
    getId();
  }

  Future<void> getId() async {
    loading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('userID');

    setState(() {
      loading = false;
    });
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder<QuerySnapshot>(
            stream: investments.where('userID', isEqualTo: id).snapshots(),
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
                      'You have no Investments Running',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ));
              }

              return new Column(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  print('docs here');
                  //print(document.reference.id);
                  print(document.data());
                  return new AllInvestmentsHistoryListCard(
                    data: document.data(),
                  );
                }).toList(),
              );
            },
          );
  }
}

// ListTile(
//     title: new Text(document.data()['number'].toString()),
//     subtitle: new Text(document.data()['date'].toString()),
//   )

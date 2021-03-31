import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/components/investmentsCard.dart';
import 'package:outlook/data_management/databases.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      child: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
        future: userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print('dash data here');
            print(data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Portfolios',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                  stream: investments
                      .where('userID', isEqualTo: data['userID'])
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'You\'ve no Investments',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print('Pressed');
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              child: Text('Get Started'))
                        ],
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new InvestmentsCard();
                      }).toList(),
                    );
                  },
                ))
              ],
            );
          }

          return Text("loading");
        },
      )),
    );
  }
}

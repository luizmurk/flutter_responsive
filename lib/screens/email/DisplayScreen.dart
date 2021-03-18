import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/models/Email.dart';
import 'package:outlook/ui_components/views/dashboard.dart';
import 'package:outlook/ui_components/views/invest.dart';
import 'package:outlook/ui_components/views/fund.dart';
import 'package:outlook/ui_components/views/investmentHistory.dart';
import 'package:outlook/ui_components/views/loadChat.dart';
import 'package:outlook/ui_components/views/transactionHistory.dart';
import 'package:outlook/ui_components/views/withdraw.dart';

import 'components/header.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({Key key, this.email, this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  final Email email;

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        //
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Header(
                    scaffoldKey: scaffoldKey,
                  )),
              //Divider(thickness: 1),
              Expanded(
                  flex: 13,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: deviceWidth * 1,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          //color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      //color: Colors.blue.withOpacity(0.05),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: uiComponents.doc("view").snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Text(
                              'Loading',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ));
                          }
                          var view = snapshot.data;
                          print('view here');
                          print(view);
                          return (view['slot'] == 1)
                              ? Dashboard()
                              : (view['slot'] == 2)
                                  ? Invest()
                                  : (view['slot'] == 3)
                                      ? Fund()
                                      : (view['slot'] == 4)
                                          ? Withdraw()
                                          : (view['slot'] == 5)
                                              ? TransactionHistory()
                                              : (view['slot'] == 6)
                                                  ? InvestmentHistory()
                                                  : (view['slot'] == 7)
                                                      ? LoadChat()
                                                      : Center(
                                                          child: Text(''),
                                                        );
                        },
                      ),
                      // Center(
                      //       child: Text('Control Panel'),
                      //     ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/components/activeInvests.dart';
import 'package:outlook/components/investmentsCard.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/styleSheet.dart';
import 'package:outlook/ui_components/forms/autoRenewTypeForm.dart';
import 'package:outlook/ui_components/forms/creditCardFundForm.dart';
import 'package:outlook/ui_components/transactionList.dart';
import 'package:outlook/ui_components/views/flutterWavePayment.dart';
import 'package:outlook/ui_components/views/payMoney.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterwave/flutterwave.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final formKey = GlobalKey<FormState>();
  // state variable
  double result = 0.0;
  int radioValue;
  bool showDetails = false;
  String fundType = '';
  dynamic userData;

  void initState() {
    super.initState();
    fundType = 'All';
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          showDetails = true;
          fundType = 'All';
          break;
        case 1:
          showDetails = true;
          fundType = 'Credit Only';
          break;
        case 2:
          showDetails = true;
          fundType = 'Debit Only';
          break;
      }
    });
  }

  saveData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('availableBalance', data['availableBalance']);
    prefs.setString('userID', data['userID']);
    prefs.setString('userDocId', '4W6tKs8VbcgTrljT1D5d');
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return (!Responsive.isMobile(context))
        ? Container(
            child: Row(
            children: [
              Expanded(
                  flex: 9,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                            child: TransactionList(
                          filter: fundType,
                        ))
                      ],
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Filter Transaction',
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      Row(
                        children: [
                          new Radio(
                            value: 0,
                            groupValue: radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('All')
                        ],
                      ),
                      Row(
                        children: [
                          new Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Credit Only')
                        ],
                      ),
                      Row(
                        children: [
                          new Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('Debit Only')
                        ],
                      ),
                    ],
                  ))
            ],
          ))
        : Container(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      flex: 15,
                      child: Container(
                        child: SafeArea(
                            child: FutureBuilder<DocumentSnapshot>(
                          future:
                              userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data = snapshot.data.data();
                              print('dash data here');
                              print(data);
                              saveData(data);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Filter Transactions',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      )),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 0,
                                        groupValue: radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text('All')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 1,
                                        groupValue: radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text('Credit Only')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 2,
                                        groupValue: radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text('Debit Only')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Expanded(
                                      child: TransactionList(
                                    filter: fundType,
                                  )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              );
                            }

                            //return Text("loading");
                          },
                        )),
                      )),
                ],
              ),
            ),
          );
  }
}

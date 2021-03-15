import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/components/activeInvests.dart';
import 'package:outlook/components/investmentsCard.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/styleSheet.dart';
import 'package:outlook/ui_components/forms/autoRenewTypeForm.dart';
import 'package:outlook/ui_components/forms/creditCardFundForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fund extends StatefulWidget {
  @override
  _FundState createState() => _FundState();
}

class _FundState extends State<Fund> {
  final formKey = GlobalKey<FormState>();
  // state variable
  double result = 0.0;
  int radioValue;
  bool showDetails = false;
  String fundType = '';

  void _handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          showDetails = true;
          fundType = 'Pay With Card';
          break;
        case 1:
          showDetails = true;
          fundType = 'Bank Transfer';
          break;
        case 2:
          showDetails = true;
          fundType = 'USSD Code';
          break;
      }
    });
  }

  saveData(data)async{
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
                  flex: 15,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: SafeArea(
                        child: FutureBuilder<DocumentSnapshot>(
                      future: userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data = snapshot.data.data();
                          print('dash data here');
                          print(data);
                          saveData(data);
                          return ListView(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Choose Funding Method',
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
                                  Text('Pay With Card')
                                ],
                              ),
                              Row(
                                children: [
                                  new Radio(
                                    value: 1,
                                    groupValue: radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text('Bank Transfer')
                                ],
                              ),
                              Row(
                                children: [
                                  new Radio(
                                    value: 2,
                                    groupValue: radioValue,
                                    onChanged: _handleRadioValueChange,
                                  ),
                                  Text('USSD Code')
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              fundType == 'Bank Transfer' && showDetails
                                  ? Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bronze Plan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '3 Fundment cycle; 75 working days',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            '40% Return on Interest',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            'Capital Range: \$100 to \$999.',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )
                                  : fundType == 'USSD Code' &&
                                          showDetails
                                      ? Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Silver Plan',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '6 Fundment cycle; 150 working days',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '85% Return on Interest',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                'Capital Range: \$1000 to \$1999.',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      : fundType == 'Pay With Card' &&
                                              showDetails
                                          ? StreamBuilder<DocumentSnapshot>(
                                stream: userCredentials
                                    .doc("4W6tKs8VbcgTrljT1D5d")
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Loading");
                                  }
                                  var creds = snapshot.data.data();
                                  print('creds here');
                                  print(creds);
                                  return showDetails
                                      ? new CreditCardForm(
                              formKey: formKey, data: creds, id: creds['userID'])
                                      : SizedBox(
                                          height: 0,
                                        );
                                },
                              )
                                          : SizedBox(
                                              height: 0,
                                            ),
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
              // Expanded(
              //     flex: 6,
              //     child: Container(
              //       decoration: BoxDecoration(
              //             color: white,
              //             borderRadius: BorderRadius.all(Radius.circular(15))),
              //       padding: EdgeInsets.all(20),
              //       child: SafeArea(
              //           child: FutureBuilder<DocumentSnapshot>(
              //         future: userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
              //         builder: (BuildContext context,
              //             AsyncSnapshot<DocumentSnapshot> snapshot) {
              //           if (snapshot.hasError) {
              //             return Text("Something went wrong");
              //           }

              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Text("Loading");
              //           }

              //           if (snapshot.connectionState == ConnectionState.done) {
              //             Map<String, dynamic> data = snapshot.data.data();
              //             print('dash data here');
              //             print(data);
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   'Portfolios',
              //                   style: TextStyle(
              //                       fontFamily: 'Acumin', letterSpacing: 2),
              //                 ),
              //                 Expanded(
              //                     child: StreamBuilder<QuerySnapshot>(
              //                   stream: investments
              //                       .where('userID', isEqualTo: data['userID'])
              //                       .snapshots(),
              //                   builder: (BuildContext context,
              //                       AsyncSnapshot<QuerySnapshot> snapshot) {
              //                     if (snapshot.hasError) {
              //                       return Text('Something went wrong');
              //                     }

              //                     if (snapshot.hasData &&
              //                         snapshot.data.docs.isEmpty) {
              //                       return Center(
              //                           child: Column(
              //                         children: [
              //                           SizedBox(
              //                             height: 85,
              //                           ),
              //                           Icon(
              //                             Icons.app_blocking,
              //                             color: Colors.grey,
              //                             size: 35.0,
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           Text(
              //                             'You\'ve no investments',
              //                             style: TextStyle(
              //                               fontSize: 15,
              //                             ),
              //                           ),
              //                           SizedBox(
              //                             height: 10,
              //                           ),
              //                           ElevatedButton(
              //                               onPressed: () {
              //                                 print('Pressed');
              //                               },
              //                               style: ButtonStyle(
              //                                 backgroundColor:
              //                                     MaterialStateProperty.all(
              //                                         Colors.orange),
              //                               ),
              //                               child: Text('Get Started'))
              //                         ],
              //                       ));
              //                     }

              //                     if (snapshot.connectionState ==
              //                         ConnectionState.waiting) {
              //                       return Text("Loading");
              //                     }

              //                     return new ListView(
              //                       children: snapshot.data.docs
              //                           .map((DocumentSnapshot document) {
              //                         return new ActiveInvests();
              //                       }).toList(),
              //                     );
              //                   },
              //                 ))
              //               ],
              //             );
              //           }

              //           return Text("loading");
              //         },
              //       )),
              //     ))
            ],
          ))
        : Container(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                        padding: EdgeInsets.all(10),
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
                                  Text(
                                    'Active investments',
                                    style: TextStyle(
                                        fontFamily: 'Acumin', letterSpacing: 2),
                                  ),
                                  Expanded(
                                      child: StreamBuilder<QuerySnapshot>(
                                    stream: investments
                                        .where('userID',
                                            isEqualTo: data['userID'])
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.hasData &&
                                          snapshot.data.docs.isEmpty) {
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
                                              'You\'ve no investments',
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
                                                      MaterialStateProperty.all(
                                                          Colors.orange),
                                                ),
                                                child: Text('Get Started'))
                                          ],
                                        ));
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }

                                      return new ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: snapshot.data.docs
                                            .map((DocumentSnapshot document) {
                                          return new ActiveInvests();
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
                      )),
                  Expanded(
                      flex: 11,
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
                              
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Choose Plan',
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
                                      Text('Lumy Bronze Plan')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 1,
                                        groupValue: radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text('Lumy Silver Plan')
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 2,
                                        groupValue: radioValue,
                                        onChanged: _handleRadioValueChange,
                                      ),
                                      Text('Lumy Gold Plan')
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  fundType == 'Lumy Bronze Plan' && showDetails
                                      ? Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Bronze Plan',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '3 Fundment cycle; 75 working days',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                '40% Return on Interest',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                'Capital Range: \$100 to \$999.',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        )
                                      : fundType == 'Lumy Silver Plan' &&
                                              showDetails
                                          ? Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Silver Plan',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '6 Fundment cycle; 150 working days',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    '85% Return on Interest',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    'Capital Range: \$1000 to \$1999.',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : fundType == 'Lumy Gold Plan' &&
                                                  showDetails
                                              ? Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Gold Plan',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '10 Fundment cycle; 250 working days',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        '130% Return on Interest',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      Text(
                                                        'Capital Range: \$2000 to \$3000.',
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Expanded(
                                      child: StreamBuilder<DocumentSnapshot>(
                                    stream: userCredentials
                                        .doc("4W6tKs8VbcgTrljT1D5d")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }
                                      var creds = snapshot.data.data();
                                      print('creds here');
                                      print(creds);
                                      return showDetails
                                          ? new AutoRenewTypeForm(
                                              formKey: formKey,
                                              plan: fundType,
                                              bal: creds['availableBalance'])
                                          : SizedBox(
                                              height: 0,
                                            );
                                    },
                                  ))
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

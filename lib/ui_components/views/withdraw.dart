import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/components/activeInvests.dart';
import 'package:outlook/components/investmentsCard.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/styleSheet.dart';
import 'package:outlook/controls/crud_control/addBankAccount.dart';
import 'package:outlook/styleSheet.dart';
import 'package:intl/intl.dart';
import '../forms/inputFormatter.dart';
import 'package:outlook/ui_components/views/flutterWavePayment.dart';
import 'package:outlook/ui_components/views/payMoney.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterwave/flutterwave.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final formKey = GlobalKey<FormState>();
  // state variable
  double result = 0.0;
  int radioValue;
  bool showDetails = false;
  String withdrawType = '';
  dynamic userData;

  void initState() {
    super.initState();
  }

  final Map<String, dynamic> formData = {
    'date': DateFormat.yMMMMd('en_US').format(new DateTime.now()).toString(),
    'userID': null,
    'amount': null,
    'account_number': null,
    'bank': null,
    'region': null,
    'first_name': null,
    'last_name': null
  };

  final Map<String, dynamic> formDataUK = {
    'date': DateFormat.yMMMMd('en_US').format(new DateTime.now()).toString(),
    'userID': null,
    'amount': null,
    'IBAN': null,
    'region': null,
    'bank': null,
    'full_name': null,
  };

  final Map<String, dynamic> formDataUS = {
    'date': DateFormat.yMMMMd('en_US').format(new DateTime.now()).toString(),
    'userID': null,
    'amount': null,
    'account_number': null,
    'bank': null,
    'routing_code': null,
    'region': null,
    'full_name': null,
  };

  void _handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          showDetails = true;
          withdrawType = 'Dollar Account';
          break;
        case 1:
          showDetails = true;
          withdrawType = 'Naira Account';
          break;
        case 2:
          showDetails = true;
          withdrawType = 'Pound Account';
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
        ? Form(
            key: formKey,
            child: Container(
                child: Row(
              children: [
                Expanded(
                    flex: 9,
                    child: Container(
                      padding: EdgeInsets.all(20),
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
                            userData = data;
                            formData['userID'] = data['userID'];
                            formDataUS['userID'] = data['userID'];
                            formDataUK['userID'] = data['userID'];
                            saveData(data);
                            return ListView(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Choose Account Type',
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
                                    Text('Dollar Account')
                                  ],
                                ),
                                Row(
                                  children: [
                                    new Radio(
                                      value: 1,
                                      groupValue: radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('Naira Account')
                                  ],
                                ),
                                Row(
                                  children: [
                                    new Radio(
                                      value: 2,
                                      groupValue: radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('Pound Account')
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                withdrawType == 'Dollar Account' && showDetails
                                    ? Container(
                                        // height: raised
                                        //     ? deviceHeight * 0.85
                                        //     : deviceHeight * 0.75,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  // border: Border.all(
                                                  //   color: Colors.red[500],
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter USD amount',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please Amount in USD';
                                                      }

                                                      var intValue = int.parse(
                                                          value.replaceAll(
                                                              RegExp('[^0-9]'),
                                                              ''));
                                                      var a = intValue;
                                                      if (a <= 10) {
                                                        return 'You cannot withdraw below \$11';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      ThousandsSeparatorInputFormatter()
                                                    ],
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      // var stringValue = formData['amount'].toString();
                                                      var intValue = int.parse(
                                                          value.replaceAll(
                                                              RegExp('[^0-9]'),
                                                              ''));
                                                      var a = intValue;
                                                      formDataUS['amount'] = a;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  // border: Border.all(
                                                  //   color: Colors.red[500],
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            '1234567890 (Account Number)',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Account number';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      formDataUS[
                                                              'account_number'] =
                                                          int.parse(value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  // border: Border.all(
                                                  //   color: Colors.red[500],
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Routing Code',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter your routing code';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      formDataUS[
                                                              'routing_code'] =
                                                          value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  // border: Border.all(
                                                  //   color: Colors.red[500],
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter your bank name',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter your bank name';
                                                      }
                                                      return null;
                                                    },
                                                    //focusNode: _focusNode,
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      formDataUS['bank'] =
                                                          value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              // width: deviceWidth * 0.4,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  // border: Border.all(
                                                  //   color: Colors.red[500],
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Account Name',
                                                    hintStyle:
                                                        inputTextStyle()),
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter Account Name';
                                                  }
                                                  return null;
                                                },
                                                //focusNode: _focusNode2,
                                                style: TextStyle(
                                                    fontFamily: 'Muli',
                                                    fontSize: 20,
                                                    letterSpacing: 1.5),
                                                onSaved: (String value) {
                                                  formDataUS['full_name'] =
                                                      value;
                                                },
                                              ),
                                            ),
                                            // raised
                                            //?
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // : SizedBox(
                                            //     height: 0,
                                            //   )
                                            CreditBankAccount(
                                                formDataUS, formKey)
                                          ],
                                        ),
                                      )
                                    : withdrawType == 'Naira Account' &&
                                            showDetails
                                        ? Container(
                                            //height: raised ? deviceHeight * 0.85 : deviceHeight * 0.45,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter USD amount',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter Amount in USD';
                                                          }

                                                          var intValue = int.parse(
                                                              value.replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''));
                                                          var a = intValue;
                                                          if (a <= 10) {
                                                            return 'You cannot withdraw below \$11';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsSeparatorInputFormatter()
                                                        ],
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          // var stringValue = formData['amount'].toString();
                                                          var intValue = int.parse(
                                                              value.replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''));
                                                          var a = intValue;
                                                          formData['amount'] =
                                                              a;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                '1234567890 (Account Number)',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter Account number';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formData[
                                                                  'account_number'] =
                                                              int.parse(value);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Divider(
                                                //   thickness: 2,
                                                //   indent: 00.0,
                                                //   endIndent: 00.0,
                                                // ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter your bank name',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter your bank name';
                                                          }
                                                          return null;
                                                        },
                                                        //focusNode: _focusNode,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formData['bank'] =
                                                              value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  // width: deviceWidth * 0.4,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Account Name',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Account Name';
                                                      }
                                                      return null;
                                                    },
                                                    //focusNode: _focusNode2,
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      formData['first_name'] =
                                                          value;
                                                    },
                                                  ),
                                                ),
                                                // raised
                                                //?
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // : SizedBox(
                                                //     height: 0,
                                                //   )
                                                CreditBankAccount(
                                                    formData, formKey)
                                              ],
                                            ),
                                          )
                                        : withdrawType == 'Pound Account' &&
                                                showDetails
                                            ? Container(
                                                // height:
                                                //     raised ? deviceHeight * 0.85 : deviceHeight * 0.65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter USD amount',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter amount in USD';
                                                              }
                                                              var intValue = int
                                                                  .parse(value
                                                                      .replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                              var a = intValue;
                                                              if (a <= 10) {
                                                                return 'You cannot withdraw below \$11';
                                                              }

                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              ThousandsSeparatorInputFormatter()
                                                            ],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              // var stringValue = formData['amount'].toString();
                                                              var intValue = int
                                                                  .parse(value
                                                                      .replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                              var a = intValue;
                                                              formDataUK[
                                                                  'amount'] = a;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'IBAN',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your IBAN';
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              formDataUK[
                                                                      'IBAN'] =
                                                                  value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Divider(
                                                    //   thickness: 2,
                                                    //   indent: 00.0,
                                                    //   endIndent: 00.0,
                                                    // ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter your bank name',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your bank name';
                                                              }
                                                              return null;
                                                            },
                                                            //focusNode: _focusNode,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              formDataUK[
                                                                      'bank'] =
                                                                  value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      // width: deviceWidth * 0.4,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Account Name',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter your Account Name';
                                                          }
                                                          return null;
                                                        },
                                                        //focusNode: _focusNode2,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formDataUK[
                                                                  'full_name'] =
                                                              value;
                                                        },
                                                      ),
                                                    ),
                                                    // raised
                                                    //?
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    // : SizedBox(
                                                    //     height: 0,
                                                    //   )
                                                    CreditBankAccount(
                                                        formDataUK, formKey)
                                                  ],
                                                ),
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
                Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: EdgeInsets.all(20),
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
                            return PayMoneyPage();
                          }

                          return Text("loading");
                        },
                      )),
                    ))
              ],
            )),
          )
        : Form(
            key: formKey,
            child: Container(
              child: SafeArea(
                child: Column(
                  children: [
                    // Expanded(
                    //     flex: 4,
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: white,
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(15))),
                    //       padding: EdgeInsets.all(10),
                    //       child: SafeArea(
                    //           child: FutureBuilder<DocumentSnapshot>(
                    //         future:
                    //             userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
                    //         builder: (BuildContext context,
                    //             AsyncSnapshot<DocumentSnapshot> snapshot) {
                    //           if (snapshot.hasError) {
                    //             return Text("Something went wrong");
                    //           }

                    //           if (snapshot.connectionState ==
                    //               ConnectionState.waiting) {
                    //             return Text("Loading");
                    //           }

                    //           if (snapshot.connectionState ==
                    //               ConnectionState.done) {
                    //             Map<String, dynamic> data = snapshot.data.data();
                    //             print('dash data here');
                    //             print(data);
                    //             saveData(data);
                    //             return Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   'Active investments',
                    //                   style: TextStyle(
                    //                       fontFamily: 'Acumin', letterSpacing: 2),
                    //                 ),
                    //                 Expanded(
                    //                     child: StreamBuilder<QuerySnapshot>(
                    //                   stream: investments
                    //                       .where('userID',
                    //                           isEqualTo: data['userID'])
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
                    //                       scrollDirection: Axis.horizontal,
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
                    //     )),
                    Expanded(
                        flex: 15,
                        child: Container(
                          child: SafeArea(
                              child: FutureBuilder<DocumentSnapshot>(
                            future: userCredentials
                                .doc("4W6tKs8VbcgTrljT1D5d")
                                .get(),
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
                                Map<String, dynamic> data =
                                    snapshot.data.data();
                                print('dash data here');
                                print(data);
                                saveData(data);
                                return ListView(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Choose Account Type',
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
                                        Text('Dollar Account')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        new Radio(
                                          value: 1,
                                          groupValue: radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        Text('Naira Account')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        new Radio(
                                          value: 2,
                                          groupValue: radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        Text('Pound Account')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    withdrawType == 'Dollar Account' &&
                                            showDetails
                                        ? Container(
                                            // height: raised
                                            //     ? deviceHeight * 0.85
                                            //     : deviceHeight * 0.75,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter USD amount',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please Amount in USD';
                                                          }

                                                          var intValue = int.parse(
                                                              value.replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''));
                                                          var a = intValue;
                                                          if (a <= 10) {
                                                            return 'You cannot withdraw below \$11';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsSeparatorInputFormatter()
                                                        ],
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          // var stringValue = formData['amount'].toString();
                                                          var intValue = int.parse(
                                                              value.replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''));
                                                          var a = intValue;
                                                          formDataUS['amount'] =
                                                              a;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                '1234567890 (Account Number)',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter Account number';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formDataUS[
                                                                  'account_number'] =
                                                              int.parse(value);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Routing Code',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter your routing code';
                                                          }
                                                          return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formDataUS[
                                                                  'routing_code'] =
                                                              value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter your bank name',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter your bank name';
                                                          }
                                                          return null;
                                                        },
                                                        //focusNode: _focusNode,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formDataUS['bank'] =
                                                              value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  // width: deviceWidth * 0.4,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: white,
                                                      // border: Border.all(
                                                      //   color: Colors.red[500],
                                                      // ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Account Name',
                                                        hintStyle:
                                                            inputTextStyle()),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Account Name';
                                                      }
                                                      return null;
                                                    },
                                                    //focusNode: _focusNode2,
                                                    style: TextStyle(
                                                        fontFamily: 'Muli',
                                                        fontSize: 20,
                                                        letterSpacing: 1.5),
                                                    onSaved: (String value) {
                                                      formDataUS['full_name'] =
                                                          value;
                                                    },
                                                  ),
                                                ),
                                                // raised
                                                //?
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                // : SizedBox(
                                                //     height: 0,
                                                //   )
                                                CreditBankAccount(
                                                    formDataUS, formKey)
                                              ],
                                            ),
                                          )
                                        : withdrawType == 'Naira Account' &&
                                                showDetails
                                            ? Container(
                                                //height: raised ? deviceHeight * 0.85 : deviceHeight * 0.45,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter USD amount',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter Amount in USD';
                                                              }

                                                              var intValue = int
                                                                  .parse(value
                                                                      .replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                              var a = intValue;
                                                              if (a <= 10) {
                                                                return 'You cannot withdraw below \$11';
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              ThousandsSeparatorInputFormatter()
                                                            ],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              // var stringValue = formData['amount'].toString();
                                                              var intValue = int
                                                                  .parse(value
                                                                      .replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                              var a = intValue;
                                                              formData[
                                                                  'amount'] = a;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    '1234567890 (Account Number)',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter Account number';
                                                              }
                                                              return null;
                                                            },
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              formData[
                                                                      'account_number'] =
                                                                  int.parse(
                                                                      value);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Divider(
                                                    //   thickness: 2,
                                                    //   indent: 00.0,
                                                    //   endIndent: 00.0,
                                                    // ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter your bank name',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your bank name';
                                                              }
                                                              return null;
                                                            },
                                                            //focusNode: _focusNode,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              formData['bank'] =
                                                                  value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      // width: deviceWidth * 0.4,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                          color: white,
                                                          // border: Border.all(
                                                          //   color: Colors.red[500],
                                                          // ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15))),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Account Name',
                                                            hintStyle:
                                                                inputTextStyle()),
                                                        validator: (value) {
                                                          if (value.isEmpty) {
                                                            return 'Please enter Account Name';
                                                          }
                                                          return null;
                                                        },
                                                        //focusNode: _focusNode2,
                                                        style: TextStyle(
                                                            fontFamily: 'Muli',
                                                            fontSize: 20,
                                                            letterSpacing: 1.5),
                                                        onSaved:
                                                            (String value) {
                                                          formData[
                                                                  'first_name'] =
                                                              value;
                                                        },
                                                      ),
                                                    ),
                                                    // raised
                                                    //?
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    // : SizedBox(
                                                    //     height: 0,
                                                    //   )
                                                    CreditBankAccount(
                                                        formData, formKey)
                                                  ],
                                                ),
                                              )
                                            : withdrawType == 'Pound Account' &&
                                                    showDetails
                                                ? Container(
                                                    // height:
                                                    //     raised ? deviceHeight * 0.85 : deviceHeight * 0.65,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: white,
                                                                  // border: Border.all(
                                                                  //   color: Colors.red[500],
                                                                  // ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Enter USD amount',
                                                                    hintStyle:
                                                                        inputTextStyle()),
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Please enter amount in USD';
                                                                  }
                                                                  var intValue =
                                                                      int.parse(value.replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                                  var a =
                                                                      intValue;
                                                                  if (a <= 10) {
                                                                    return 'You cannot withdraw below \$11';
                                                                  }

                                                                  return null;
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  ThousandsSeparatorInputFormatter()
                                                                ],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Muli',
                                                                    fontSize:
                                                                        20,
                                                                    letterSpacing:
                                                                        1.5),
                                                                onSaved: (String
                                                                    value) {
                                                                  // var stringValue = formData['amount'].toString();
                                                                  var intValue =
                                                                      int.parse(value.replaceAll(
                                                                          RegExp(
                                                                              '[^0-9]'),
                                                                          ''));
                                                                  var a =
                                                                      intValue;
                                                                  formDataUK[
                                                                      'amount'] = a;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: white,
                                                                  // border: Border.all(
                                                                  //   color: Colors.red[500],
                                                                  // ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'IBAN',
                                                                    hintStyle:
                                                                        inputTextStyle()),
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Please enter your IBAN';
                                                                  }
                                                                  return null;
                                                                },
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Muli',
                                                                    fontSize:
                                                                        20,
                                                                    letterSpacing:
                                                                        1.5),
                                                                onSaved: (String
                                                                    value) {
                                                                  formDataUK[
                                                                          'IBAN'] =
                                                                      value;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // Divider(
                                                        //   thickness: 2,
                                                        //   indent: 00.0,
                                                        //   endIndent: 00.0,
                                                        // ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: white,
                                                                  // border: Border.all(
                                                                  //   color: Colors.red[500],
                                                                  // ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                          child: Column(
                                                            children: [
                                                              TextFormField(
                                                                decoration: InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        'Enter your bank name',
                                                                    hintStyle:
                                                                        inputTextStyle()),
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return 'Please enter your bank name';
                                                                  }
                                                                  return null;
                                                                },
                                                                //focusNode: _focusNode,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Muli',
                                                                    fontSize:
                                                                        20,
                                                                    letterSpacing:
                                                                        1.5),
                                                                onSaved: (String
                                                                    value) {
                                                                  formDataUK[
                                                                          'bank'] =
                                                                      value;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          // width: deviceWidth * 0.4,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: white,
                                                                  // border: Border.all(
                                                                  //   color: Colors.red[500],
                                                                  // ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              15))),
                                                          child: TextFormField(
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Account Name',
                                                                hintStyle:
                                                                    inputTextStyle()),
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your Account Name';
                                                              }
                                                              return null;
                                                            },
                                                            //focusNode: _focusNode2,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Muli',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    1.5),
                                                            onSaved:
                                                                (String value) {
                                                              formDataUK[
                                                                      'full_name'] =
                                                                  value;
                                                            },
                                                          ),
                                                        ),
                                                        // raised
                                                        //?
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        // : SizedBox(
                                                        //     height: 0,
                                                        //   )
                                                        CreditBankAccount(
                                                            formDataUK, formKey)
                                                      ],
                                                    ),
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
                  ],
                ),
              ),
            ),
          );
  }
}

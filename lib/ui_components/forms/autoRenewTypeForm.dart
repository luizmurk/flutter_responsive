import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/autoRenewInvest.dart';
import 'package:outlook/styleSheet.dart';
import 'package:outlook/ui_components/forms/inputFormatter.dart';
import 'package:intl/intl.dart';

class AutoRenewTypeForm extends StatefulWidget {
  final int value;
  final formKey;
  final plan;
  final bal;

  const AutoRenewTypeForm(
      {Key key, this.formKey, this.value = 0, this.plan, this.bal});

  @override
  _AutoRenewTypeFormState createState() => _AutoRenewTypeFormState();
}

class _AutoRenewTypeFormState extends State<AutoRenewTypeForm> {
  int selectedRadioTile;
  int selectedRadio;
  dynamic today;
  dynamic daysTime;

  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> formData = {
      'date_of_investment': null,
      'amount_invested': null,
      'plan': null,
      'investment_period': null,
      'due_date': null,
      'interest': null,
      'interest_amount': null,
      'roic': null
    };
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text('Set Investment',
              //     textAlign: TextAlign.left, style: menuLabel()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: white,
                    // border: Border.all(
                    //   color: Colors.red[500],
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter USD amount',
                          hintStyle: inputTextStyle()),
                      validator: (value) {
                        if (value.isNotEmpty) {
                          var intValue =
                              int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                          var a = intValue;
                          if (a > widget.bal) {
                            return 'Insuficient funds, add funds to your wallet';
                          }
                          if (a < 100) {
                            return 'You can not invest below \$100';
                          }
                          if (widget.plan == 'Lumy Bronze Plan') {
                            if (a < 100) {
                              return 'You can not invest below \$100 for this plan';
                            } else if (a > 999) {
                              return 'You can not invest above \$999 for this plan';
                            } else {
                              return null;
                            }
                          }
                          if (widget.plan == 'Lumy Silver Plan') {
                            if (a < 100) {
                              return 'You can not invest below \$100 for this plan';
                            } else if (a > 1999) {
                              return 'You can not invest above \$1999 for this plan';
                            } else {
                              return null;
                            }
                          }
                          if (widget.plan == 'Lumy Gold Plan') {
                            if (a < 100) {
                              return 'You can not invest below \$100 for this plan';
                            } else if (a > 3000) {
                              return 'You can not invest above \$3000 for this plan';
                            } else {
                              return null;
                            }
                          }
                        }
                        if (value.isEmpty) {
                          return 'Please enter an amount';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [ThousandsSeparatorInputFormatter()],
                      style: TextStyle(
                          fontFamily: 'Muli', fontSize: 20, letterSpacing: 1.5),
                      onSaved: (String value) {
                        // var stringValue = formData['amount'].toString();
                        var intValue =
                            int.parse(value.replaceAll(RegExp('[^0-9]'), ''));
                        var a = intValue;
                        today = new DateTime.now();
                        if (today.weekday == 6) {
                          print('today is saturday');
                          today = today.add(new Duration(days: 2));
                          print("weekday is ${today.weekday}");
                        } else if (today.weekday == 7) {
                          print('today is not sunday');
                          today = today.add(new Duration(days: 1));
                          print("weekday is ${today.weekday}");
                        }
                        formData['date_of_investment'] =
                            DateFormat.yMMMMd('en_US')
                                .format(new DateTime.now())
                                .toString();
                        if (widget.plan == 'Lumy Bronze Plan') {
                          formData['plan'] = 'Lumy Bronze Plan';
                          formData['investment_period'] = 105;
                          daysTime = today.add(new Duration(days: 105));
                          formData['due_date'] = DateFormat.yMMMMd('en_US')
                              .format(daysTime)
                              .toString();
                          formData['interest'] = '40%';
                          var roi = a * 0.40;
                          formData['interest_amount'] = roi;
                          var roic = a + roi;
                          formData['roic'] = roic;
                          print(today);
                          print(daysTime);
                        }
                        if (widget.plan == 'Lumy Silver Plan') {
                          formData['plan'] = 'Lumy Silver Plan';
                          formData['investment_period'] = 210;
                          daysTime = today.add(new Duration(days: 210));
                          formData['due_date'] = DateFormat.yMMMMd('en_US')
                              .format(daysTime)
                              .toString();
                          formData['interest'] = '85%';
                          var roi = a * 0.85;
                          formData['interest_amount'] = roi;
                          var roic = a + roi;
                          formData['roic'] = roic;
                          print(today);
                          print(daysTime);
                        }
                        if (widget.plan == 'Lumy Gold Plan') {
                          formData['plan'] = 'Lumy Gold Plan';
                          formData['investment_period'] = 250;
                          daysTime = today.add(new Duration(days: 315));
                          formData['due_date'] = DateFormat.yMMMMd('en_US')
                              .format(daysTime)
                              .toString();
                          formData['interest'] = '130%';
                          var roi = a * 1.30;
                          formData['interest_amount'] = roi;
                          var roic = a + roi;
                          formData['roic'] = roic;
                          print(today);
                          print(daysTime);
                        }
                        formData['amount_invested'] = a;
                        print('form here');
                        print(formData);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AutoRenewInvest(formData, widget.formKey),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

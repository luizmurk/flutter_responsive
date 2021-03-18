import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/addCreditCard.dart';
import 'package:outlook/controls/crud_control/deleteUserCard.dart';
import 'package:outlook/controls/routes.dart';
import 'package:outlook/responsive.dart';
//mport 'package:outlook/pages/fundWallet.dart';
import 'package:outlook/styleSheet.dart';
import 'package:http/http.dart' as http;
import 'package:outlook/ui_components/views/desktopPaystackPayment.dart';
//import 'package:outlook/pages/payMoney.dart';

class CreditCardForm extends StatefulWidget {
  final int value;
  final formKey;
  final data;
  final id;

  const CreditCardForm(
      {Key key, this.formKey, this.value = 0, this.data, this.id});

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  int selectedRadioTile;
  int selectedRadio;
  bool card1 = false;
  bool card2 = false;
  bool card3 = false;
  bool showFakeCard;
  String cardOne;
  String cardTwo;
  String cardThree;
  double usdEquivalent;
  dynamic ngn;
  dynamic uk;
  dynamic amount;
  dynamic card;

  double result = 0.0;
  int radioValue;
  bool showPayment = false;
  bool showPaystack = false;
  String fundType = '';

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    showFakeCard = false;
    fetchRates();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('focused');
        setState(() {});
      } else {
        print('not focused');
      }
    });
  }

  Future<dynamic> fetchRates() async {
    final response = await http.get(
        'https://v6.exchangerate-api.com/v6/4f91b54b299015bce129cb75/latest/USD');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('done')));
      print('success');
      var map = jsonDecode(response.body);
      ngn = map['conversion_rates']['NGN'];
      uk = map['conversion_rates']['GBP'];
      print(ngn);
      print(uk);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('We encountered an error')));
      throw Exception('Failed to load album');
    }
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          showPayment = true;
          //fundType = 'Pay With Card';
          card = widget.data['credit_cards']['card1'];
          break;
        case 1:
          showPayment = true;
          //fundType = 'Bank Transfer';
          card = widget.data['credit_cards']['card2'];
          break;
        case 2:
          showPayment = true;
          //fundType = 'USSD Code';
          card = widget.data['credit_cards']['card3'];
          break;
      }
    });
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> formData = {
      'cardNumber': null,
      'exp_month': null,
      'exp_year': null,
      'cvv': null,
      'cardName': null
    };

    if (widget.data['credit_cards']['card1'] != null) {
      var string =
          widget.data['credit_cards']['card1']['cardNumber'].toString();
      cardOne = string.substring(string.length - 4);
    }

    if (widget.data['credit_cards']['card2'] != null) {
      var string =
          widget.data['credit_cards']['card2']['cardNumber'].toString();
      cardTwo = string.substring(string.length - 4);
    }

    if (widget.data['credit_cards']['card3'] != null) {
      var string =
          widget.data['credit_cards']['card2']['cardNumber'].toString();
      cardThree = string.substring(string.length - 4);
    }

    return (!Responsive.isMobile(context))
        ? Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.data['credit_cards']['card1'] != null &&
                //         widget.data['credit_cards']['card2'] != null &&
                //         widget.data['credit_cards']['card3'] != null
                //     ? Text('Select Card to Fund',
                //         textAlign: TextAlign.left, style: menuLabel())
                //     : Text(''),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data['credit_cards']['card1'] == null &&
                            widget.data['credit_cards']['card2'] == null &&
                            widget.data['credit_cards']['card3'] == null
                        ? Center(
                            child: Text(
                              'Your Saved Cards Show Here, \nSave a card with the Form below.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          )
                        : Text('Select Payment Card to Pay',
                            textAlign: TextAlign.left, style: menuLabel()),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card1'] != null
                        ? Row(
                            children: [
                              new Radio(
                                value: 0,
                                groupValue: radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              ElevatedButton(
                                // width: deviceWidth * 0.3,
                                // padding: EdgeInsets.all(10),
                                // decoration: BoxDecoration(
                                //     color: Colors.lightBlue,
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black.withOpacity(0.2),
                                //         blurRadius: 2.7, // soften the shadow
                                //         spreadRadius: 2, //extend the shadow
                                //         offset: Offset(
                                //           2.0, // Move to right 10  horizontally
                                //           2.0, // Move to bottom 5 Vertically
                                //         ),
                                //       )
                                //     ],
                                //     borderRadius: BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  print('Presed');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  primary: Colors.lightBlue,
                                ),
                                child: Container(
                                  width: deviceWidth * 0.34,
                                  child: ListTile(
                                    title: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card1']),
                                        //     context);
                                      },
                                      child: Text(
                                        '**** **** **** $cardOne',
                                        style: TextStyle(
                                            color: white, fontSize: 20),
                                      ),
                                    ),
                                    subtitle: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card1']),
                                        //     context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Expiry Date:  ',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card1']['exp_month']}',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '/',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card1']['exp_year']}',
                                            style: TextStyle(color: white),
                                          )
                                        ],
                                      ),
                                    ),
                                    trailing: DeleteUserCards(
                                        widget.formKey, widget.id, 1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card2'] != null
                        ? Row(
                            children: [
                              new Radio(
                                value: 1,
                                groupValue: radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              ElevatedButton(
                                // width: deviceWidth * 0.3,
                                // padding: EdgeInsets.all(10),
                                // decoration: BoxDecoration(
                                //     color: Colors.lightBlue,
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black.withOpacity(0.2),
                                //         blurRadius: 2.7, // soften the shadow
                                //         spreadRadius: 2, //extend the shadow
                                //         offset: Offset(
                                //           2.0, // Move to right 10  horizontally
                                //           2.0, // Move to bottom 5 Vertically
                                //         ),
                                //       )
                                //     ],
                                //     borderRadius: BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  print('Presed');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  primary: Colors.lightBlue,
                                ),
                                child: Container(
                                  width: deviceWidth * 0.34,
                                  child: ListTile(
                                    title: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card2']),
                                        //     context);
                                      },
                                      child: Text(
                                        '**** **** **** $cardTwo',
                                        style: TextStyle(
                                            color: white, fontSize: 20),
                                      ),
                                    ),
                                    subtitle: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card2']),
                                        //     context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Expiry Date:  ',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card2']['exp_month']}',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '/',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card2']['exp_year']}',
                                            style: TextStyle(color: white),
                                          )
                                        ],
                                      ),
                                    ),
                                    trailing: DeleteUserCards(
                                        widget.formKey, widget.id, 2),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card3'] != null
                        ? Row(
                            children: [
                              new Radio(
                                value: 0,
                                groupValue: radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              ElevatedButton(
                                // width: deviceWidth * 0.3,
                                // padding: EdgeInsets.all(10),
                                // decoration: BoxDecoration(
                                //     color: Colors.lightBlue,
                                //     boxShadow: [
                                //       BoxShadow(
                                //         color: Colors.black.withOpacity(0.2),
                                //         blurRadius: 2.7, // soften the shadow
                                //         spreadRadius: 2, //extend the shadow
                                //         offset: Offset(
                                //           2.0, // Move to right 10  horizontally
                                //           2.0, // Move to bottom 5 Vertically
                                //         ),
                                //       )
                                //     ],
                                //     borderRadius: BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  print('Presed');
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  primary: Colors.lightBlue,
                                ),
                                child: Container(
                                  width: deviceWidth * 0.34,
                                  child: ListTile(
                                    title: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card3']),
                                        //     context);
                                      },
                                      child: Text(
                                        '**** **** **** $cardThree',
                                        style: TextStyle(
                                            color: white, fontSize: 20),
                                      ),
                                    ),
                                    subtitle: GestureDetector(
                                      onTap: () {
                                        // goTo(
                                        //     PayMoneyPage(
                                        //         email: widget.data['email'],
                                        //         cardDetails: widget.data['credit_cards']
                                        //             ['card1']),
                                        //     context);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Expiry Date:  ',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card3']['exp_month']}',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '/',
                                            style: TextStyle(color: white),
                                          ),
                                          Text(
                                            '${widget.data['credit_cards']['card3']['exp_year']}',
                                            style: TextStyle(color: white),
                                          )
                                        ],
                                      ),
                                    ),
                                    trailing: DeleteUserCards(
                                        widget.formKey, widget.id, 3),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Text('')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Payment Card',
                        textAlign: TextAlign.left, style: menuLabel()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                !showPayment && !showPaystack
                    ? Container(
                        height: deviceHeight * 0.18,
                        width: deviceWidth * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: white,
                                  // border: Border.all(
                                  //   color: Colors.red[500],
                                  // ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0000 0000 0000',
                                    hintStyle: inputTextStyle()),
                                focusNode: _focusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter card number';
                                  }
                                  return null;
                                },
                                //maxLength: 19,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 20,
                                    letterSpacing: 1.5),
                                onSaved: (String value) {
                                  var number = int.parse(value);
                                  formData['cardNumber'] = number;
                                  var nameList = value.split('');
                                  var name =
                                      'card: ...${nameList[nameList.length - 4]}${nameList[nameList.length - 3]}${nameList[nameList.length - 2]}${nameList[nameList.length - 1]}';
                                  formData['cardName'] = name;
                                },
                                keyboardType: TextInputType.number,
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: deviceWidth * 0.1,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: white,
                                            // border: Border.all(
                                            //   color: Colors.red[500],
                                            // ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'MM',
                                              hintStyle: inputTextStyle()),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'exp mm';
                                            }
                                            return null;
                                          },
                                          //maxLength: 2,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontFamily: 'Muli',
                                              fontSize: 20,
                                              letterSpacing: 1.5),
                                          onSaved: (String value) {
                                            formData['exp_month'] = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('-',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.grey)),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Container(
                                        width: deviceWidth * 0.1,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: white,
                                            // border: Border.all(
                                            //   color: Colors.red[500],
                                            // ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'YY',
                                              hintStyle: inputTextStyle()),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'exp yy';
                                            }
                                            return null;
                                          },
                                          //maxLength: 2,
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontFamily: 'Muli',
                                              fontSize: 20,
                                              letterSpacing: 1.5),
                                          onSaved: (String value) {
                                            formData['exp_year'] = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: deviceWidth * 0.15,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: white,
                                        // border: Border.all(
                                        //   color: Colors.red[500],
                                        // ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'CVV',
                                          hintStyle: inputTextStyle()),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter cards cvv';
                                        }
                                        return null;
                                      },
                                      //maxLength: 3,
                                      style: TextStyle(
                                          fontFamily: 'Muli',
                                          fontSize: 20,
                                          letterSpacing: 1.5),
                                      onSaved: (String value) {
                                        var number = int.parse(value);
                                        formData['cvv'] = number;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : showPayment && !showPaystack
                        ? Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: white,
                                // border: Border.all(
                                //   color: Colors.red[500],
                                // ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter amount',
                                  hintStyle: inputTextStyle()),
                              focusNode: _focusNode,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                return null;
                              },
                              //maxLength: 19,
                              style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontSize: 20,
                                  letterSpacing: 1.5),
                              onSaved: (String value) {
                                // if (widget.formKey.currentState.validate()) {
                                //       widget.formKey.currentState
                                //           .save(); //onSaved is called!
                                var stringValue = value.toString();
                                var intValue = int.parse(stringValue.replaceAll(
                                    RegExp('[^0-9]'), ''));
                                amount = intValue;
                                var a = intValue;
                                //var b = widget.rate.round();
                                var b = double.parse((ngn).toStringAsFixed(2));

                                var usd = a / b;
                                print(a);
                                print(b);
                                print(usd);

                                var step2 = usd.toStringAsFixed(2);
                                print(step2); // 0.33

                                var step3 = double.parse(step2);
                                print(step3); // 0.33
                                usdEquivalent = step3;
                                //setState(() {});
                                //  }
                              },
                              keyboardType: TextInputType.number,
                            ),
                          )
                        : showPaystack
                            ? PayWithPayStackDesktop(
                                email: widget.data['email'],
                                cardDetails: card,
                                amount: amount,
                                usd: usdEquivalent,
                              )
                            : SizedBox(),
                !showPayment && !showPaystack
                    ? Container(
                        child: widget.data['credit_cards']['card1'] == null
                            ? AddUserCards(
                                formData, widget.formKey, widget.id, 1)
                            : widget.data['credit_cards']['card1'] != null &&
                                    widget.data['credit_cards']['card2'] == null
                                ? AddUserCards(
                                    formData, widget.formKey, widget.id, 2)
                                : widget.data['credit_cards']['card2'] !=
                                            null &&
                                        widget.data['credit_cards']['card3'] ==
                                            null
                                    ? AddUserCards(
                                        formData, widget.formKey, widget.id, 3)
                                    : Text(''),
                      )
                    : showPayment && !showPaystack
                        ? Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPayment = !showPayment;
                                        radioValue = null;
                                      });
                                    },
                                    child: Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {
                                      print('Pressed pay with paystackStart');
                                      if (widget.formKey.currentState
                                          .validate()) {
                                        widget.formKey.currentState
                                            .save(); //onSaved is called!
                                        print(
                                            'Pressed pay with paystackContinues');
                                        setState(() {
                                          showPaystack = true;
                                        });
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.orange),
                                    ),
                                    child: Text('Pay with Flutterwave'))
                              ],
                            ))
                        : showPaystack
                            ? Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showPaystack = !showPaystack;
                                            //radioValue = null;
                                          });
                                        },
                                        child: Text('Cancel'))
                                  ],
                                ))
                            : SizedBox(),
              ],
            ),
          )
        : Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.data['credit_cards']['card1'] != null &&
                //         widget.data['credit_cards']['card2'] != null &&
                //         widget.data['credit_cards']['card3'] != null
                //     ? Text('Select Card to Fund',
                //         textAlign: TextAlign.left, style: menuLabel())
                //     : Text(''),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data['credit_cards']['card1'] == null &&
                            widget.data['credit_cards']['card2'] == null &&
                            widget.data['credit_cards']['card3'] == null
                        ? Center(
                            child: Text(
                              'Your Saved Cards Show Here, \nSave a card with the Form below.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          )
                        : Text('Select Payment Card to Pay',
                            textAlign: TextAlign.left, style: menuLabel()),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card1'] != null
                        ? ElevatedButton(
                            // width: deviceWidth * 0.3,
                            // padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //     color: Colors.lightBlue,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.2),
                            //         blurRadius: 2.7, // soften the shadow
                            //         spreadRadius: 2, //extend the shadow
                            //         offset: Offset(
                            //           2.0, // Move to right 10  horizontally
                            //           2.0, // Move to bottom 5 Vertically
                            //         ),
                            //       )
                            //     ],
                            //     borderRadius: BorderRadius.all(Radius.circular(5))),
                            onPressed: () {
                              print('Presed');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Colors.lightBlue,
                            ),
                            child: Container(
                              //width: deviceWidth * 0.4,
                              child: ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card1']),
                                    //     context);
                                  },
                                  child: Text(
                                    '**** **** **** $cardOne',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  ),
                                ),
                                subtitle: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card1']),
                                    //     context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Expiry Date:  ',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card1']['exp_month']}',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '/',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card1']['exp_year']}',
                                        style: TextStyle(color: white),
                                      )
                                    ],
                                  ),
                                ),
                                trailing: DeleteUserCards(
                                    widget.formKey, widget.id, 1),
                              ),
                            ),
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card2'] != null
                        ? ElevatedButton(
                            // width: deviceWidth * 0.3,
                            // padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //     color: Colors.lightBlue,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.2),
                            //         blurRadius: 2.7, // soften the shadow
                            //         spreadRadius: 2, //extend the shadow
                            //         offset: Offset(
                            //           2.0, // Move to right 10  horizontally
                            //           2.0, // Move to bottom 5 Vertically
                            //         ),
                            //       )
                            //     ],
                            //     borderRadius: BorderRadius.all(Radius.circular(5))),
                            onPressed: () {
                              print('Presed');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Colors.lightBlue,
                            ),
                            child: Container(
                              //width: deviceWidth * 0.4,
                              child: ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card2']),
                                    //     context);
                                  },
                                  child: Text(
                                    '**** **** **** $cardTwo',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  ),
                                ),
                                subtitle: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card2']),
                                    //     context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Expiry Date:  ',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card2']['exp_month']}',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '/',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card2']['exp_year']}',
                                        style: TextStyle(color: white),
                                      )
                                    ],
                                  ),
                                ),
                                trailing: DeleteUserCards(
                                    widget.formKey, widget.id, 2),
                              ),
                            ),
                          )
                        : Text(''),
                    SizedBox(
                      height: 10,
                    ),
                    widget.data['credit_cards']['card3'] != null
                        ? ElevatedButton(
                            // width: deviceWidth * 0.3,
                            // padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //     color: Colors.lightBlue,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.2),
                            //         blurRadius: 2.7, // soften the shadow
                            //         spreadRadius: 2, //extend the shadow
                            //         offset: Offset(
                            //           2.0, // Move to right 10  horizontally
                            //           2.0, // Move to bottom 5 Vertically
                            //         ),
                            //       )
                            //     ],
                            //     borderRadius: BorderRadius.all(Radius.circular(5))),
                            onPressed: () {
                              print('Presed');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Colors.lightBlue,
                            ),
                            child: Container(
                              //width: deviceWidth * 0.4,
                              child: ListTile(
                                title: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card3']),
                                    //     context);
                                  },
                                  child: Text(
                                    '**** **** **** $cardThree',
                                    style:
                                        TextStyle(color: white, fontSize: 20),
                                  ),
                                ),
                                subtitle: GestureDetector(
                                  onTap: () {
                                    // goTo(
                                    //     PayMoneyPage(
                                    //         email: widget.data['email'],
                                    //         cardDetails: widget.data['credit_cards']
                                    //             ['card1']),
                                    //     context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Expiry Date:  ',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card3']['exp_month']}',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '/',
                                        style: TextStyle(color: white),
                                      ),
                                      Text(
                                        '${widget.data['credit_cards']['card3']['exp_year']}',
                                        style: TextStyle(color: white),
                                      )
                                    ],
                                  ),
                                ),
                                trailing: DeleteUserCards(
                                    widget.formKey, widget.id, 3),
                              ),
                            ),
                          )
                        : Text('')
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Add Payment Card',
                        textAlign: TextAlign.left, style: menuLabel()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: deviceHeight * 0.25,
                  width: deviceWidth * 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: white,
                            // border: Border.all(
                            //   color: Colors.red[500],
                            // ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '0000 0000 0000',
                              hintStyle: inputTextStyle()),
                          focusNode: _focusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter card number';
                            }
                            return null;
                          },
                          //maxLength: 19,
                          style: TextStyle(
                              fontFamily: 'Muli',
                              fontSize: 20,
                              letterSpacing: 1.5),
                          onSaved: (String value) {
                            var number = int.parse(value);
                            formData['cardNumber'] = number;
                            var nameList = value.split('');
                            var name =
                                'card: ...${nameList[nameList.length - 4]}${nameList[nameList.length - 3]}${nameList[nameList.length - 2]}${nameList[nameList.length - 1]}';
                            formData['cardName'] = name;
                          },
                          keyboardType: TextInputType.number,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: deviceWidth * 0.15,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      // border: Border.all(
                                      //   color: Colors.red[500],
                                      // ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'MM',
                                        hintStyle: inputTextStyle()),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'exp mm';
                                      }
                                      return null;
                                    },
                                    //maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        letterSpacing: 1.5),
                                    onSaved: (String value) {
                                      formData['exp_month'] = value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text('-',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.grey)),
                                SizedBox(
                                  width: 3,
                                ),
                                Container(
                                  width: deviceWidth * 0.15,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      // border: Border.all(
                                      //   color: Colors.red[500],
                                      // ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'YY',
                                        hintStyle: inputTextStyle()),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'exp yy';
                                      }
                                      return null;
                                    },
                                    //maxLength: 2,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        letterSpacing: 1.5),
                                    onSaved: (String value) {
                                      formData['exp_year'] = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: deviceWidth * 0.35,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: white,
                                  // border: Border.all(
                                  //   color: Colors.red[500],
                                  // ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'CVV',
                                    hintStyle: inputTextStyle()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter cards cvv';
                                  }
                                  return null;
                                },
                                //maxLength: 3,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 20,
                                    letterSpacing: 1.5),
                                onSaved: (String value) {
                                  var number = int.parse(value);
                                  formData['cvv'] = number;
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                widget.data['credit_cards']['card1'] == null
                    ? AddUserCards(formData, widget.formKey, widget.id, 1)
                    : widget.data['credit_cards']['card1'] != null &&
                            widget.data['credit_cards']['card2'] == null
                        ? AddUserCards(formData, widget.formKey, widget.id, 2)
                        : widget.data['credit_cards']['card2'] != null &&
                                widget.data['credit_cards']['card3'] == null
                            ? AddUserCards(
                                formData, widget.formKey, widget.id, 3)
                            : Text('')
              ],
            ),
          );
  }
}

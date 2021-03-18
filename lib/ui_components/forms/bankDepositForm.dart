import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/addBankAccount.dart';
import 'package:outlook/styleSheet.dart';
import 'package:intl/intl.dart';
import '../forms/inputFormatter.dart';

class BankDepositForm extends StatefulWidget {
  final int value;
  final formKey;
  final dynamic id;

  const BankDepositForm({Key key, this.formKey, this.value = 0, this.id});

  @override
  _BankDepositFormState createState() => _BankDepositFormState();
}

class _BankDepositFormState extends State<BankDepositForm> {
  int selectedRadioTile;
  int selectedRadio;
  final List fundTypes = ['USD', 'NGN', 'GBP'];
  String fundType;
  bool showDropDown;
  bool raised;
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

  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    fundType = 'Choose Currency';
    showDropDown = false;
    formData['userID'] = widget.id;
    formDataUS['userID'] = widget.id;
    formDataUK['userID'] = widget.id;
    raised = false;

    //   _focusNode.addListener(() {
    //     if (_focusNode.hasFocus) {
    //       print('focused');
    //       setState(() {
    //         raised = true;
    //       });
    //     } else {
    //       setState(() {
    //         raised = false;
    //       });
    //       print('not focused');
    //     }
    //   });

    //   _focusNode2.addListener(() {
    //     if (_focusNode2.hasFocus) {
    //       print('focused');
    //       setState(() {
    //         raised = true;
    //       });
    //     } else {
    //       setState(() {
    //         raised = false;
    //       });
    //       print('not focused');
    //     }
    //   });

    //   _focusNode3.addListener(() {
    //     if (_focusNode3.hasFocus) {
    //       print('focused');
    //       setState(() {
    //         raised = true;
    //       });
    //     } else {
    //       setState(() {
    //         raised = false;
    //       });
    //       print('not focused');
    //     }
    //   });
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

    return Form(
      key: widget.formKey,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fill Bank Details',
                    textAlign: TextAlign.left, style: menuLabel()),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  showDropDown = !showDropDown;
                });
              },
              child: Container(
                  height: deviceHeight * 0.082,
                  width: deviceWidth * 1,
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: deviceWidth * 0.67,
                          child: dropDownText('$fundType')),
                      Icon(
                        Icons.arrow_drop_down,
                        color: darkgrey,
                        size: 34.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            showDropDown
                ? Container(
                    width: deviceWidth * 1,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(fundTypes.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              //loading = true;

                              fundType = fundTypes[index];
                              showDropDown = false;
                              formData['region'] = fundType;
                              formDataUK['region'] = fundType;
                              formDataUS['region'] = fundType;
                              setState(() {});
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                width: deviceWidth * 0.66,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    // border: Border.all(
                                    //   color: Colors.red[500],
                                    // ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: fundTypes[index] == 'NGN'
                                    ? Text(
                                        'NGN',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Muli',
                                            fontWeight: FontWeight.w600),
                                      )
                                    : fundTypes[index] == 'USD'
                                        ? Text(
                                            'USD',
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'Muli',
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            'GBP',
                                            style: TextStyle(
                                                color: white,
                                                fontFamily: 'Muli',
                                                fontWeight: FontWeight.w600),
                                          )),
                          );
                        })))
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 15,
            ),

            //NGN BANK FORM

            fundType == 'NGN'
                ? Container(
                    //height: raised ? deviceHeight * 0.85 : deviceHeight * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter USD amount',
                                    hintStyle: inputTextStyle()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Amount in USD';
                                  }

                                  var intValue = int.parse(
                                      value.replaceAll(RegExp('[^0-9]'), ''));
                                  var a = intValue;
                                  if (a <= 10) {
                                    return 'You cannot withdraw below \$11';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
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
                                      value.replaceAll(RegExp('[^0-9]'), ''));
                                  var a = intValue;
                                  formData['amount'] = a;
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
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '1234567890 (Account Number)',
                                    hintStyle: inputTextStyle()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter Account number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 20,
                                    letterSpacing: 1.5),
                                onSaved: (String value) {
                                  formData['account_number'] = int.parse(value);
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
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your bank name',
                                    hintStyle: inputTextStyle()),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your bank name';
                                  }
                                  return null;
                                },
                                //focusNode: _focusNode,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontFamily: 'Muli',
                                    fontSize: 20,
                                    letterSpacing: 1.5),
                                onSaved: (String value) {
                                  formData['bank'] = value;
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
                                  BorderRadius.all(Radius.circular(15))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Account Name',
                                hintStyle: inputTextStyle()),
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
                              formData['first_name'] = value;
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
                        CreditBankAccount(formData, widget.formKey)
                      ],
                    ),
                  )

                //UK BANK FORM

                : fundType == 'GBP'
                    ? Container(
                        // height:
                        //     raised ? deviceHeight * 0.85 : deviceHeight * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter USD amount',
                                        hintStyle: inputTextStyle()),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter amount in USD';
                                      }
                                      var intValue = int.parse(value.replaceAll(
                                          RegExp('[^0-9]'), ''));
                                      var a = intValue;
                                      if (a <= 10) {
                                        return 'You cannot withdraw below \$11';
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      ThousandsSeparatorInputFormatter()
                                    ],
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        letterSpacing: 1.5),
                                    onSaved: (String value) {
                                      // var stringValue = formData['amount'].toString();
                                      var intValue = int.parse(value.replaceAll(
                                          RegExp('[^0-9]'), ''));
                                      var a = intValue;
                                      formDataUK['amount'] = a;
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
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'IBAN',
                                        hintStyle: inputTextStyle()),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your IBAN';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontFamily: 'Muli',
                                        fontSize: 20,
                                        letterSpacing: 1.5),
                                    onSaved: (String value) {
                                      formDataUK['IBAN'] = value;
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
                                      BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter your bank name',
                                        hintStyle: inputTextStyle()),
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
                                      formDataUK['bank'] = value;
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
                                      BorderRadius.all(Radius.circular(15))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Account Name',
                                    hintStyle: inputTextStyle()),
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
                                onSaved: (String value) {
                                  formDataUK['full_name'] = value;
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
                            CreditBankAccount(formDataUK, widget.formKey)
                          ],
                        ),
                      )
                    :

                    //US BANK FORM

                    fundType == 'USD'
                        ? Container(
                            // height: raised
                            //     ? deviceHeight * 0.85
                            //     : deviceHeight * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      // border: Border.all(
                                      //   color: Colors.red[500],
                                      // ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter USD amount',
                                            hintStyle: inputTextStyle()),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please Amount in USD';
                                          }

                                          var intValue = int.parse(
                                              value.replaceAll(
                                                  RegExp('[^0-9]'), ''));
                                          var a = intValue;
                                          if (a <= 10) {
                                            return 'You cannot withdraw below \$11';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
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
                                                  RegExp('[^0-9]'), ''));
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                '1234567890 (Account Number)',
                                            hintStyle: inputTextStyle()),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Account number';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            fontFamily: 'Muli',
                                            fontSize: 20,
                                            letterSpacing: 1.5),
                                        onSaved: (String value) {
                                          formDataUS['account_number'] =
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Routing Code',
                                            hintStyle: inputTextStyle()),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter your routing code';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            fontFamily: 'Muli',
                                            fontSize: 20,
                                            letterSpacing: 1.5),
                                        onSaved: (String value) {
                                          formDataUS['routing_code'] = value;
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Enter your bank name',
                                            hintStyle: inputTextStyle()),
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
                                          formDataUS['bank'] = value;
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Account Name',
                                        hintStyle: inputTextStyle()),
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
                                      formDataUS['full_name'] = value;
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
                                CreditBankAccount(formDataUS, widget.formKey)
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //     margin: EdgeInsets.only(right: 5),
            //     child: fundType == 'US'
            //         ? CreditBankAccount(formDataUS, widget.formKey)
            //         : fundType == 'UK'
            //             ? CreditBankAccount(formDataUK, widget.formKey)
            //             : CreditBankAccount(formData, widget.formKey))
          ],
        ),
      ),
    );
  }
}

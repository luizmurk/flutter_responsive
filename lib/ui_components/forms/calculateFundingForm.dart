import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/defaultInvest.dart';
import 'package:outlook/controls/routes.dart';
import 'package:outlook/styleSheet.dart';
//import 'package:outlook/pages/paystackPayment.dart';

import '../forms/inputFormatter.dart';

class CalculateFundingForm extends StatefulWidget {
  final int value;
  final rate;
  final bool convertable;
  final String region;
  final dynamic email;
  final dynamic data;

  const CalculateFundingForm(
      {Key key,
      this.value = 0,
      this.rate,
      this.convertable,
      this.region,
      this.email,
      this.data});

  @override
  _CalculateFundingFormState createState() => _CalculateFundingFormState();
}

class _CalculateFundingFormState extends State<CalculateFundingForm> {
  int selectedRadioTile;
  int selectedRadio;
  double usdEquivalent;
  List fundTypes;
  String fundType;
  bool showDropDown;

  dynamic amount;
  final Map<String, dynamic> formData = {'amount': null};
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    usdEquivalent = 0;
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

    if (widget.region == 'NGN') {
      fundTypes = [
        'Pay with Paystack',
      ];
    } else if (widget.region == 'USD') {
      fundTypes = ['Pay with Paystack'];
    } else if (widget.region == 'GBP') {
      fundTypes = ['Pay with Paystack'];
    }
    return Form(
      key: formKey,
      child: widget.convertable
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: deviceHeight * 0.25,
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
                                  hintText: '000.00 (enter fund amount)',
                                  hintStyle: inputTextStyle()),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter an amount';
                                }
                                return null;
                              },
                              style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontSize: 20,
                                  letterSpacing: 1.5),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsSeparatorInputFormatter()
                              ],
                              onSaved: (String value) {
                                formData['amount'] = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      widget.convertable
                          ? GestureDetector(
                              onTap: () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState
                                      .save(); //onSaved is called!
                                  var stringValue =
                                      formData['amount'].toString();
                                  var intValue = int.parse(stringValue
                                      .replaceAll(RegExp('[^0-9]'), ''));
                                  var a = intValue;
                                  //var b = widget.rate.round();
                                  var b = double.parse(
                                      (widget.rate).toStringAsFixed(2));

                                  var usd = a / b;
                                  print(a);
                                  print(b);
                                  print(usd);

                                  var step2 = usd.toStringAsFixed(2);
                                  print(step2); // 0.33

                                  var step3 = double.parse(step2);
                                  print(step3); // 0.33
                                  usdEquivalent = step3;
                                  setState(() {});
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2.0, // soften the shadow
                                        spreadRadius: 1, //extend the shadow
                                        offset: Offset(
                                          2.0, // Move to right 10  horizontally
                                          2.0, // Move to bottom 5 Vertically
                                        ),
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                alignment: Alignment.center,
                                width: deviceWidth * 1,
                                height: deviceHeight * 0.05,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Convert ${widget.region} to USD',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'ABeeZee'),
                                ),
                              ),
                            )
                          : Text(''),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                usdEquivalent != 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('USD Equivalent',
                              textAlign: TextAlign.left, style: menuLabel()),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(10),
                              height: deviceHeight * 0.1,
                              width: deviceWidth * 1,
                              decoration: BoxDecoration(
                                  color: white,
                                  // border: Border.all(
                                  //   color: Colors.red[500],
                                  // ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Text(
                                '\$$usdEquivalent',
                                style:
                                    TextStyle(fontSize: 25, fontFamily: 'Muli'),
                              )),
                        ],
                      )
                    : Text(''),
                SizedBox(
                  height: 25,
                ),
                usdEquivalent != 0
                    ? Container(
                        width: deviceWidth * 1,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(fundTypes.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    fundType = fundTypes[index];
                                    showDropDown = false;
                                  });
                                  print('going to paystack');
                                  if (fundType == 'Pay with Paystack') {
                                    print('going to paystack');
                                    var stringValue =
                                        formData['amount'].toString();
                                    var intValue = int.parse(stringValue
                                        .replaceAll(RegExp('[^0-9]'), ''));
                                    var a = intValue;
                                    // goToReplacement(
                                    //     PayWithPayStack(
                                    //       email: widget.email,
                                    //       cardDetails: widget.data,
                                    //       amount: a,
                                    //       usd: usdEquivalent,
                                    //     ),
                                    //     context);
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: deviceWidth * 1,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        // border: Border.all(
                                        //   color: Colors.red[500],
                                        // ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          fundType = fundTypes[index];
                                          showDropDown = false;
                                        });
                                        print('going to paystack');
                                        if (fundType == 'Pay with Paystack') {
                                          print('going to paystack');
                                          var stringValue =
                                              formData['amount'].toString();
                                          var intValue = int.parse(
                                              stringValue.replaceAll(
                                                  RegExp('[^0-9]'), ''));
                                          var a = intValue;
                                          //goToReplacement(
                                          // PayWithPayStack(
                                          //   email: widget.email,
                                          //   cardDetails: widget.data,
                                          //   amount: a,
                                          //   usd: usdEquivalent,
                                          // ),
                                          // context
                                          // );
                                        }
                                      },
                                      child: Text(
                                        '${fundTypes[index]}',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Muli',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )),
                              );
                            })))
                    : Text('')
              ],
            )
          : Text(''),
    );
  }
}

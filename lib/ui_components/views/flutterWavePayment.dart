import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:http/http.dart' as http;

import '../../styleSheet.dart';

class PaymentWidget extends StatefulWidget {
  final int value;
  final formKey;
  final data;
  final id;

  const PaymentWidget(
      {Key key, this.formKey, this.value = 0, this.data, this.id});

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final String txref = "My_unique_transaction_reference_123";
  //final String amount = "200";
  final String currency = FlutterwaveCurrency.RWF;
  double usdEquivalent;
  dynamic ngn;
  dynamic uk;
  dynamic amount;
  dynamic card;

  FocusNode _focusNode = FocusNode();
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                borderRadius: BorderRadius.all(Radius.circular(15))),
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
                  fontFamily: 'Muli', fontSize: 20, letterSpacing: 1.5),
              onSaved: (String value) {
                // if (widget.formKey.currentState.validate()) {
                //       widget.formKey.currentState
                //           .save(); //onSaved is called!
                var stringValue = value.toString();
                var intValue =
                    int.parse(stringValue.replaceAll(RegExp('[^0-9]'), ''));
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
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                print('Pressed pay with paystackStart');
                if (widget.formKey.currentState.validate()) {
                  widget.formKey.currentState.save(); //onSaved is called!
                  print('Pressed pay with paystackContinues');
                  beginPayment(context, amount);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              child: Text('Pay with Paystack'))
        ],
      ),
    );
  }

  beginPayment(BuildContext context, amount) async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        encryptionKey: "FLWPUBK_TEST-SANDBOXDEMOKEY-X",
        publicKey: "FLWPUBK_TEST-SANDBOXDEMOKEY-X",
        currency: this.currency,
        amount: amount,
        email: "will4odia@email.com",
        fullName: "Will Odia",
        txRef: this.txref,
        isDebugMode: true,
        phoneNumber: "07051154032",
        acceptCardPayment: true,
        acceptUSSDPayment: false,
        acceptAccountPayment: false,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction. Payment wasn't successful.
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          // provide value to customer
        } else {
          // check message
          print(response.message);

          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
      // print(stacktrace);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }
}

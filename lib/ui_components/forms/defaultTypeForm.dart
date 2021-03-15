import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/addBankAccount.dart';
import 'package:outlook/controls/crud_control/addCreditCard.dart';
import 'package:outlook/controls/crud_control/add_credit_card.dart';
import 'package:outlook/controls/crud_control/defaultInvest.dart';
import 'package:outlook/controls/crud_control/fundBankAccount.dart';
import 'package:outlook/controls/crud_control/fundWithCreditCard.dart';
import 'package:outlook/controls/crud_control/manualInvest.dart';
import 'package:outlook/controls/media.dart';
import 'package:outlook/styleSheet.dart';

class DefaultTypeForm extends StatefulWidget {
  final int value;
  final formKey;

  const DefaultTypeForm({
    Key key,
    this.formKey,
    this.value = 0,
  });

  @override
  _DefaultTypeFormState createState() => _DefaultTypeFormState();
}

class _DefaultTypeFormState extends State<DefaultTypeForm> {
  int selectedRadioTile;
  int selectedRadio;

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
      'cardNumber': null,
      'date': null,
      'cvv': null
    };
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('+ Set Investment',
                  textAlign: TextAlign.left, style: menuLabel()),
              DefaultInvest(formData['cardNumber'], formData['date'],
                  formData['cvv'], formData, widget.formKey)
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: deviceHeight * 0.15,
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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '000.00 (enter amount to invest)',
                            hintStyle: inputTextStyle()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter card number';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          formData['cardNumber'] = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

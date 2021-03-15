import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/controls/routes.dart';
import 'package:outlook/data_management/databases.dart';
//import 'package:outlook/pages/drawWallet.dart';
import 'package:outlook/styleSheet.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditBankAccount extends StatefulWidget {
  final dynamic formData;
  //final formKey;

  final formkey;

  CreditBankAccount(this.formData, this.formkey);

  @override
  _CreditBankAccountState createState() => _CreditBankAccountState();
}

class _CreditBankAccountState extends State<CreditBankAccount> {
  dynamic bal;

  void initState() {
    super.initState();
    getBalance();
  }

  getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bal = prefs.getDouble('availableBalance');
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> updateBalance() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var docID = prefs.getString('userDocId');
      var a = prefs.getDouble('availableBalance');
      var b = widget.formData['amount'];
      var newBalance = a - b;
      print('new balance');
      print(newBalance);
      prefs.setDouble('availableBalance', newBalance);
      return userCredentials
          .doc(docID)
          .update({'availableBalance': newBalance}).then((value) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Done Processing Data')));
        //goToReplacement(DrawFundsPage(), context);
      }).catchError((error) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('An error occured')));
      });
    }

    Future<void> creditBankAccount() {
      // Call the user's CollectionReference to add a new user
      return payouts.add(widget.formData).then((value) {
        transactionHistory.add({
          'date':
              DateFormat.yMMMMd('en_US').format(new DateTime.now()).toString(),
          'type': 'debit',
          'amount': widget.formData['amount'],
          'method': 'bank transfer',
          'card_name': 'no card',
          'reference_number': 'no refrence',
          'merchant': widget.formData['bank'],
          'userID': widget.formData['userID'],
        }).then((value) {
          updateBalance();
        }).catchError((error) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('An error occured')));
        });
      }).catchError((error) => print("Failed to add user: $error"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .0),
      child: GestureDetector(
        onTap: () {
          print('Submitting form');
          if (this.widget.formkey.currentState.validate()) {
            this.widget.formkey.currentState.save(); //onSaved is called!

            print(widget.formData);
            if (widget.formData['region'] == null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content:
                      Text('You must pick a region you are withdrawing from')));
            } else if (bal < widget.formData['amount']) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Insufucient Fund')));
            } else {
              this.widget.formkey.currentState.reset();
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: green,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Request Sent')));
              creditBankAccount();
            }
          }
        },
        child: Container(
          //margin: EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
              color: Colors.lightBlue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: 1, //extend the shadow
                  offset: Offset(
                    1.0, // Move to right 10  horizontally
                    1.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(15))),
          alignment: Alignment.center,
          width: deviceWidth * 1,
          height: deviceHeight * 0.08,
          child: Text(
            'Submit Request',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'ABeeZee', color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// onPressed: () {
//
// },

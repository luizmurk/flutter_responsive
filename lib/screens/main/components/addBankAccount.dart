import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> creditBankAccount() {
      // Call the user's CollectionReference to add a new user
      return FirebaseFirestore.instance
          .collection('userCredentials')
          .doc()
          .update({
            'status': widget.formData['status'],
            'update_message': widget.formData['update_message'],
            'expected_delivery_date': widget.formData['expected_delivery_date'],
            'route': widget.formData['route'],
            'delivery_man_contact': widget.formData['delivery_man_contact'],
          })
          .then((value) {})
          .catchError((error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('An error occured')));
          });
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('You must pick a region you are withdrawing from')));
            } else if (bal < widget.formData['amount']) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Insufucient Fund')));
            } else {
              this.widget.formkey.currentState.reset();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
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

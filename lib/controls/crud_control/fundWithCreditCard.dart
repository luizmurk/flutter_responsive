import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/styleSheet.dart';

class FundWithCreditCard extends StatefulWidget {
  final int number;
  final int date;
  final int cvv;
  final dynamic formData;
  //final formKey;

  final formkey;

  FundWithCreditCard(
      this.number, this.date, this.cvv, this.formData, this.formkey);

  @override
  _FundWithCreditCardState createState() => _FundWithCreditCardState();
}

class _FundWithCreditCardState extends State<FundWithCreditCard> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> fundWithCreditCard() {
      // Call the user's CollectionReference to add a new user
      return cards
          .add({
            'number': widget.number, // John Doe
            'date': widget.date, // Stokes and Sons
            'cvv': widget.cvv // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .0),
      child: GestureDetector(
        onTap: () {
          print('Submitting form');
          if (this.widget.formkey.currentState.validate()) {
            this.widget.formkey.currentState.save(); //onSaved is called!
            print(widget.formData);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
            fundWithCreditCard();
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Done Processing Data')));
          }
        },
        child: Container(
          width: deviceWidth * 1,
          alignment: Alignment.center,
          height: deviceHeight * 0.07,
          decoration: BoxDecoration(
              color: scaffoldColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.0, // soften the shadow
                  spreadRadius: 1, //extend the shadow
                  offset: Offset(
                    2.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 5 Vertically
                  ),
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: buttonTextReal('Fund with Card'),
        ),
      ),
    );
  }
}

// onPressed: () {
//             print('Submitting form');
//             if (this.widget.formkey.currentState.validate()) {
//               this.widget.formkey.currentState.save(); //onSaved is called!
//               print(widget.formData);
//               Scaffold.of(context)
//                   .showSnackBar(SnackBar(content: Text('Processing Data')));
//               FundWithCreditCard();
//               Scaffold.of(context).showSnackBar(
//                   SnackBar(content: Text('Done Processing Data')));
//             }
//           },

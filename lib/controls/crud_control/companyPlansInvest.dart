import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/styleSheet.dart';

class CompanyPlansInvest extends StatefulWidget {
  final int number;
  final int date;
  final int cvv;
  final dynamic formData;
  //final formKey;

  final formkey;

  CompanyPlansInvest(
      this.number, this.date, this.cvv, this.formData, this.formkey);

  @override
  _CompanyPlansInvestState createState() => _CompanyPlansInvestState();
}

class _CompanyPlansInvestState extends State<CompanyPlansInvest> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> CompanyPlansInvest() {
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
            CompanyPlansInvest();
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Done Processing Data')));
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
              borderRadius: BorderRadius.all(Radius.circular(15))),
          alignment: Alignment.center,
          width: deviceWidth * 0.2,
          height: deviceHeight * 0.04,
          child: Text(
            'Invest',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'ABeeZee'),
          ),
        ),
      ),
    );
  }
}

// onPressed: () {
//
// },

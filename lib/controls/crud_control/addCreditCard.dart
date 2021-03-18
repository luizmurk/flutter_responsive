import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/controls/routes.dart';
import 'package:outlook/data_management/databases.dart';
// import 'package:outlook/pages/fundWallet.dart';
// import 'package:outlook/pages/successPages/fundWallet.dart';
import 'package:outlook/styleSheet.dart';
//import 'package:cool_alert/cool_alert.dart';

class AddUserCards extends StatefulWidget {
  final dynamic formData;
  final dynamic id;
  final dynamic card;
  //final formKey;

  final formkey;

  AddUserCards(this.formData, this.formkey, this.id, this.card);

  @override
  _AddUserCardsState createState() => _AddUserCardsState();
}

class _AddUserCardsState extends State<AddUserCards> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> addUserCard1() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card1': widget.formData}).then((value) {
        setState(() {});
      }).catchError((error) {
        setState(() {});
      });
    }

    Future<void> addUserCard2() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card2': widget.formData}).then((value) {
        setState(() {});
      }).catchError((error) {
        setState(() {});
      });
    }

    Future<void> addUserCard3() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card3': widget.formData}).then((value) {
        setState(() {});
      }).catchError((error) {
        setState(() {});
      });
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: .0),
        child: ElevatedButton(
            onPressed: () {
              print('Submitting form');
              if (this.widget.formkey.currentState.validate()) {
                this.widget.formkey.currentState.save(); //onSaved is called!
                this.widget.formkey.currentState.reset();

                print(widget.formData);
                Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: green,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Card Saved')));
                if (widget.card == 1) {
                  addUserCard1();
                } else if (widget.card == 2) {
                  addUserCard2();
                } else if (widget.card == 3) {
                  addUserCard3();
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
            ),
            child: Text('Save Card')));
  }
}

// onPressed: () {
//
// },

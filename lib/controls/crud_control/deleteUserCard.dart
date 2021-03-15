import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/controls/routes.dart';
import 'package:outlook/data_management/databases.dart';
//import 'package:outlook/pages/fundWallet.dart';
import 'package:outlook/styleSheet.dart';

class DeleteUserCards extends StatefulWidget {
  final dynamic id;
  final dynamic card;
  //final formKey;

  final formkey;

  DeleteUserCards(this.formkey, this.id, this.card);

  @override
  _DeleteUserCardsState createState() => _DeleteUserCardsState();
}

class _DeleteUserCardsState extends State<DeleteUserCards> {
  @override
  Widget build(BuildContext context) {
    print('built deletor');
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> deleteUserCard1() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card1': null}).then((value) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Done Processing Data')));
        //goToReplacement(FundPage(), context);
      }).catchError((error) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Something went Wrong')));
      });
    }

    Future<void> deleteUserCard2() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card2': null})
          .then((value) {})
          .catchError((error) {});
    }

    Future<void> deleteUserCard3() {
      // Call the user's CollectionReference to add a new user
      return userCredentials
          .doc(widget.id)
          .update({'credit_cards.card3': null})
          .then((value) {})
          .catchError((error) {});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .0),
      child: GestureDetector(
        onTap: () {
          print('deleting'); //onSaved is called!

          Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              content: Text('Card Deleted')));
          if (widget.card == 1) {
            deleteUserCard1();
          } else if (widget.card == 2) {
            deleteUserCard2();
          } else if (widget.card == 3) {
            deleteUserCard3();
          }
        },
        child: Icon(
          Icons.delete,
          color: Color(0xFFf4978e),
          size: 24.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      ),
    );
  }
}

// onPressed: () {
//
// },

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';

class AddUser extends StatefulWidget {
  final int number;
  final int date;
  final int cvv;
  final dynamic formData;
  //final formKey;

  final formkey;

  AddUser(this.number, this.date, this.cvv, this.formData, this.formkey);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> addUser() {
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
      child: Container(
        width: deviceWidth * 0.5,
        child: ElevatedButton(
          onPressed: () {
            print('Submitting form');
            if (this.widget.formkey.currentState.validate()) {
              this.widget.formkey.currentState.save(); //onSaved is called!
              print(widget.formData);
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
              addUser();
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Done Processing Data')));
            }
          },
          child: Text('Submit'),
        ),
      ),
    );
  }
}

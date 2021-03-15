import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/styleSheet.dart';

class UpdateProfile extends StatefulWidget {
  final dynamic formData;
  final dynamic id;
  //final formKey;

  final formkey;

  UpdateProfile(this.formData, this.formkey, this.id);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    Future<void> updateProfile() {
      // Call the user's CollectionReference to add a new user
      return users
          .doc(widget.id)
          .update(widget.formData)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: .0),
      child: GestureDetector(
        onTap: () {
          print('Submitting form');
          if (1 == 1) {
            this.widget.formkey.currentState.save(); //onSaved is called!
            print(widget.formData);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
            updateProfile();
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
            'Submit',
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

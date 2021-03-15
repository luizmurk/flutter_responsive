import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/addCreditCard.dart';
import 'package:outlook/controls/crud_control/add_credit_card.dart';
import 'package:outlook/controls/crud_control/fundWithCreditCard.dart';
import 'package:outlook/controls/crud_control/updateProfile.dart';
import 'package:outlook/controls/media.dart';
import 'package:outlook/styleSheet.dart';

class ProfileForm extends StatefulWidget {
  final int value;
  final formKey;
  dynamic data;
  dynamic id;

  ProfileForm({Key key, this.formKey, this.value = 0, this.data, this.id});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  int selectedRadioTile;
  int selectedRadio;
  Map<String, dynamic> formData;

  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    formData = {
      'phone_number': widget.data['phone_number'],
      'first_name': widget.data['first_name'],
      'last_name': widget.data['last_name'],
      'house_address': widget.data['house_address'],
      'state': widget.data['state'],
      'city': widget.data['city'],
    };
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    print('your profile');
    print(widget.data);
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Update Profile',
                  textAlign: TextAlign.left, style: menuLabel()),
              Container(
                  margin: EdgeInsets.only(right: 5),
                  child: UpdateProfile(formData, widget.formKey, widget.id))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: deviceHeight * 0.58,
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
                            hintText: widget.data['phone_number'] == null
                                ? 'phone number'
                                : '${widget.data['phone_number']}',
                            hintStyle: inputTextStyle()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          if (value != '') {
                            formData['phone_number'] = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   thickness: 2,
                //   indent: 00.0,
                //   endIndent: 00.0,
                // ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: deviceWidth * 0.4,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: white,
                            // border: Border.all(
                            //   color: Colors.red[500],
                            // ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.data['first_name'] == null
                                  ? 'first name'
                                  : '${widget.data['first_name']}',
                              hintStyle: inputTextStyle()),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            if (value != '') {
                              formData['first_name'] = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        width: deviceWidth * 0.4,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: white,
                            // border: Border.all(
                            //   color: Colors.red[500],
                            // ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.data['last_name'] == null
                                  ? 'last name'
                                  : '${widget.data['last_name']}',
                              hintStyle: inputTextStyle()),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            if (value != '') {
                              formData['last_name'] = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
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
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: widget.data['house_address'] == null
                                ? 'house address'
                                : '${widget.data['house_address']}',
                            hintStyle: inputTextStyle()),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          if (value != '') {
                            formData['house_address'] = value;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: deviceWidth * 0.4,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: white,
                            // border: Border.all(
                            //   color: Colors.red[500],
                            // ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.data['state'] == null
                                  ? 'state'
                                  : '${widget.data['state']}',
                              hintStyle: inputTextStyle()),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your state';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            if (value != '') {
                              formData['state'] = value;
                            }
                          },
                        ),
                      ),
                      Container(
                        width: deviceWidth * 0.4,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: white,
                            // border: Border.all(
                            //   color: Colors.red[500],
                            // ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.data['city'] == null
                                  ? 'city'
                                  : '${widget.data['city']}',
                              hintStyle: inputTextStyle()),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            if (value != '') {
                              formData['city'] = value;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 125,
          ),
        ],
      ),
    );
  }
}

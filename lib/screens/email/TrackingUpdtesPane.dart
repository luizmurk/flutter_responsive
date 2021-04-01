import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outlook/models/Email.dart';
import 'package:outlook/screens/main/components/addBankAccount.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';
import 'components/header.dart';

class TrackingUpdatesPane extends StatefulWidget {
  const TrackingUpdatesPane({
    Key key,
    this.email,
  }) : super(key: key);

  final CustomersQouteRequest email;

  @override
  _TrackingUpdatesPaneState createState() => _TrackingUpdatesPaneState();
}

class _TrackingUpdatesPaneState extends State<TrackingUpdatesPane> {
  final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formDataUK = {
    'status': 'may 12th',
    'update_message': null,
    'expected_delivery_date': null,
    'route': null,
    'delivery_man_contact': null,
    'id': null
  };
  @override
  Widget build(BuildContext context) {
    formDataUK['id'] = widget.email.tracking_code;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Header(),
              Divider(thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(widget.email.full_name),
                      ),
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: widget.email.full_name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                          children: [
                                            TextSpan(
                                                text: widget.email.email,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Inspiration for our new home",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  "Today at 15:32",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Update the delivery status for this shipment",
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xFF4D5875),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Form(
                                        key: formKey,
                                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                                        child: Container(
                                          // height:
                                          //     raised ? deviceHeight * 0.85 : deviceHeight * 0.65,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    // border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'delivery status',
                                                        // hintStyle: inputTextStyle()
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter amount in USD';
                                                        }

                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.text,
                                                      inputFormatters: [
                                                        // ThousandsSeparatorInputFormatter()
                                                      ],
                                                      style: TextStyle(
                                                          fontFamily: 'Muli',
                                                          fontSize: 15,
                                                          letterSpacing: 1.5),
                                                      onSaved: (String value) {
                                                        formDataUK['status'] =
                                                            value;
                                                      },
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
                                                    color: Colors.grey[50],
                                                    // border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'update message',
                                                        // hintStyle: inputTextStyle()
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter your message';
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.text,
                                                      style: TextStyle(
                                                          fontFamily: 'Muli',
                                                          fontSize: 15,
                                                          letterSpacing: 1.5),
                                                      onSaved: (String value) {
                                                        formDataUK[
                                                                'update_message'] =
                                                            value;
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
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    // border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Expected delivery date',
                                                        // hintStyle: inputTextStyle()
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter your bank name';
                                                        }
                                                        return null;
                                                      },
                                                      //focusNode: _focusNode,
                                                      style: TextStyle(
                                                          fontFamily: 'Muli',
                                                          fontSize: 15,
                                                          letterSpacing: 1.5),
                                                      onSaved: (String value) {
                                                        formDataUK[
                                                                'expected_delivery_date'] =
                                                            value;
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                // width: deviceWidth * 0.4,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    // border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'current route location',
                                                    // hintStyle: inputTextStyle()
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your Account Name';
                                                    }
                                                    return null;
                                                  },
                                                  //focusNode: _focusNode2,
                                                  style: TextStyle(
                                                      fontFamily: 'Muli',
                                                      fontSize: 15,
                                                      letterSpacing: 1.5),
                                                  onSaved: (String value) {
                                                    formDataUK['route'] = value;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                // width: deviceWidth * 0.4,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    // border: Border.all(
                                                    //   color: Colors.red[500],
                                                    // ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'delivery man contact',
                                                    // hintStyle: inputTextStyle()
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your Account Name';
                                                    }
                                                    return null;
                                                  },
                                                  //focusNode: _focusNode2,
                                                  style: TextStyle(
                                                      fontFamily: 'Muli',
                                                      fontSize: 15,
                                                      letterSpacing: 1.5),
                                                  onSaved: (String value) {
                                                    formDataUK[
                                                            'delivery_man_contact'] =
                                                        value;
                                                  },
                                                ),
                                              ),
                                              // raised
                                              //?
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // : SizedBox(
                                              //     height: 0,
                                              //   )
                                              CreditBankAccount(
                                                  formDataUK, formKey)
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

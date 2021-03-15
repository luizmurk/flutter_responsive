import 'package:flutter/material.dart';
import 'package:outlook/controls/crud_control/addCreditCard.dart';
import 'package:outlook/controls/crud_control/deleteUserCard.dart';
import 'package:outlook/controls/routes.dart';
//mport 'package:outlook/pages/fundWallet.dart';
import 'package:outlook/styleSheet.dart';
//import 'package:outlook/pages/payMoney.dart';

class CreditCardForm extends StatefulWidget {
  final int value;
  final formKey;
  final data;
  final id;

  const CreditCardForm(
      {Key key, this.formKey, this.value = 0, this.data, this.id});

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  int selectedRadioTile;
  int selectedRadio;
  bool card1 = false;
  bool card2 = false;
  bool card3 = false;
  bool showFakeCard;
  String cardOne;
  String cardTwo;
  String cardThree;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    showFakeCard = false;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        print('focused');
        setState(() {});
      } else {
        print('not focused');
      }
    });
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    final Map<String, dynamic> formData = {
      'cardNumber': null,
      'exp_month': null,
      'exp_year': null,
      'cvv': null,
      'cardName': null
    };

    if (widget.data['credit_cards']['card1'] != null) {
      var string =
          widget.data['credit_cards']['card1']['cardNumber'].toString();
      cardOne = string.substring(string.length - 4);
    }

    if (widget.data['credit_cards']['card2'] != null) {
      var string =
          widget.data['credit_cards']['card2']['cardNumber'].toString();
      cardTwo = string.substring(string.length - 4);
    }

    if (widget.data['credit_cards']['card3'] != null) {
      var string =
          widget.data['credit_cards']['card2']['cardNumber'].toString();
      cardThree = string.substring(string.length - 4);
    }

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // widget.data['credit_cards']['card1'] != null &&
          //         widget.data['credit_cards']['card2'] != null &&
          //         widget.data['credit_cards']['card3'] != null
          //     ? Text('Select Card to Fund',
          //         textAlign: TextAlign.left, style: menuLabel())
          //     : Text(''),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.data['credit_cards']['card1'] == null &&
                      widget.data['credit_cards']['card2'] == null &&
                      widget.data['credit_cards']['card3'] == null
                  ? Center(
                      child: Text(
                        'Your Saved Cards Show Here, \nSave a card with the Form below.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    )
                  : Text('Select Payment Card to Pay',
                      textAlign: TextAlign.left, style: menuLabel()),
              SizedBox(
                height: 10,
              ),
              widget.data['credit_cards']['card1'] != null
                  ? Container(
                      width: deviceWidth * 0.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2.7, // soften the shadow
                              spreadRadius: 2, //extend the shadow
                              offset: Offset(
                                2.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card1']),
                            //     context);
                          },
                          child: Text(
                            '**** **** **** $cardOne',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card1']),
                            //     context);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Expiry Date:  ',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card1']['exp_month']}',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '/',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card1']['exp_year']}',
                                style: TextStyle(color: white),
                              )
                            ],
                          ),
                        ),
                        trailing: DeleteUserCards(widget.formKey, widget.id, 1),
                      ),
                    )
                  : Text(''),
              SizedBox(
                height: 10,
              ),
              widget.data['credit_cards']['card2'] != null
                  ? Container(
                      width: deviceWidth * 0.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2.7, // soften the shadow
                              spreadRadius: 2, //extend the shadow
                              offset: Offset(
                                2.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card2']),
                            //     context);
                          },
                          child: Text(
                            '**** **** **** $cardTwo',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card2']),
                            //     context);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Expiry Date:  ',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card2']['exp_month']}',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '/',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card2']['exp_year']}',
                                style: TextStyle(color: white),
                              )
                            ],
                          ),
                        ),
                        trailing: DeleteUserCards(widget.formKey, widget.id, 2),
                      ),
                    )
                  : Text(''),
              SizedBox(
                height: 10,
              ),
              widget.data['credit_cards']['card3'] != null
                  ? Container(
                      width: deviceWidth * 0.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2.7, // soften the shadow
                              spreadRadius: 2, //extend the shadow
                              offset: Offset(
                                2.0, // Move to right 10  horizontally
                                2.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card3']),
                            //     context);
                          },
                          child: Text(
                            '**** **** **** $cardThree',
                            style: TextStyle(color: white, fontSize: 20),
                          ),
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            // goTo(
                            //     PayMoneyPage(
                            //         email: widget.data['email'],
                            //         cardDetails: widget.data['credit_cards']
                            //             ['card1']),
                            //     context);
                          },
                          child: Row(
                            children: [
                              Text(
                                'Expiry Date:  ',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card3']['exp_month']}',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '/',
                                style: TextStyle(color: white),
                              ),
                              Text(
                                '${widget.data['credit_cards']['card3']['exp_year']}',
                                style: TextStyle(color: white),
                              )
                            ],
                          ),
                        ),
                        trailing: DeleteUserCards(widget.formKey, widget.id, 3),
                      ),
                    )
                  : Text('')
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Payment Card',
                  textAlign: TextAlign.left, style: menuLabel()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: deviceHeight * 0.31,
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
                            hintText: '0000 0000 0000',
                            hintStyle: inputTextStyle()),
                        focusNode: _focusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter card number';
                          }
                          return null;
                        },
                        maxLength: 19,
                        style: TextStyle(
                            fontFamily: 'Muli',
                            fontSize: 20,
                            letterSpacing: 1.5),
                        onSaved: (String value) {
                          var number = int.parse(value);
                          formData['cardNumber'] = number;
                          var nameList = value.split('');
                          var name =
                              'card: ...${nameList[nameList.length - 4]}${nameList[nameList.length - 3]}${nameList[nameList.length - 2]}${nameList[nameList.length - 1]}';
                          formData['cardName'] = name;
                        },
                        keyboardType: TextInputType.number,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: deviceWidth * 0.15,
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
                                  hintText: 'MM',
                                  hintStyle: inputTextStyle()),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'exp mm';
                                }
                                return null;
                              },
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontSize: 20,
                                  letterSpacing: 1.5),
                              onSaved: (String value) {
                                formData['exp_month'] = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text('-',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.grey)),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            width: deviceWidth * 0.15,
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
                                  hintText: 'YY',
                                  hintStyle: inputTextStyle()),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'exp yy';
                                }
                                return null;
                              },
                              maxLength: 2,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontFamily: 'Muli',
                                  fontSize: 20,
                                  letterSpacing: 1.5),
                              onSaved: (String value) {
                                formData['exp_year'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: deviceWidth * 0.25,
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
                              hintText: 'CVV',
                              hintStyle: inputTextStyle()),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter cards cvv';
                            }
                            return null;
                          },
                          maxLength: 3,
                          style: TextStyle(
                              fontFamily: 'Muli',
                              fontSize: 20,
                              letterSpacing: 1.5),
                          onSaved: (String value) {
                            var number = int.parse(value);
                            formData['cvv'] = number;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          widget.data['credit_cards']['card1'] == null
              ? AddUserCards(formData, widget.formKey, widget.id, 1)
              : widget.data['credit_cards']['card1'] != null &&
                      widget.data['credit_cards']['card2'] == null
                  ? AddUserCards(formData, widget.formKey, widget.id, 2)
                  : widget.data['credit_cards']['card2'] != null &&
                          widget.data['credit_cards']['card3'] == null
                      ? AddUserCards(formData, widget.formKey, widget.id, 3)
                      : Text('')
        ],
      ),
    );
  }
}

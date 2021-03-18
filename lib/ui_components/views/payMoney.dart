import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outlook/styleSheet.dart';
// import 'package:outlook/ui_components/headerBack.dart';
import 'package:outlook/ui_components/forms/calculateFundingForm.dart';
import 'package:http/http.dart' as http;

class PayMoneyPage extends StatefulWidget {
  PayMoneyPage({Key key, this.email, this.cardDetails}) : super(key: key);

  final dynamic cardDetails;
  final dynamic email;

  @override
  _PayMoneyPageState createState() => _PayMoneyPageState();
}

class _PayMoneyPageState extends State<PayMoneyPage> {
  final List fundTypes = ['USD', 'NGN', 'GBP'];
  String fundType;
  bool showDropDown;
  dynamic map;
  dynamic ngn;
  dynamic usd = 1;
  dynamic uk;
  bool convertable;
  bool loading;
  @override
  void initState() {
    super.initState();
    fundType = 'Choose Currency';
    showDropDown = false;
    convertable = false;
    loading = false;
    print(widget.cardDetails);
    print(widget.email);
  }

  Future<dynamic> fetchRates() async {
    final response = await http.get(
        'https://v6.exchangerate-api.com/v6/4f91b54b299015bce129cb75/latest/USD');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('done')));
      print('success');
      map = jsonDecode(response.body);
      ngn = map['conversion_rates']['NGN'];
      uk = map['conversion_rates']['GBP'];
      print(ngn);
      print(uk);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // Scaffold.of(context)
      //     .showSnackBar(SnackBar(content: Text('We encountered an error')));
      throw Exception('Failed to load album');
    }
  }

  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeaderBack(),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Text('Currency Calculator',
                      textAlign: TextAlign.left, style: menuLabel()),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showDropDown = !showDropDown;
                      });
                    },
                    child: Container(
                        height: deviceHeight * 0.082,
                        width: deviceWidth * 1,
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: deviceWidth * 0.19,
                                child: dropDownText('$fundType')),
                            Icon(
                              Icons.arrow_drop_down,
                              color: darkgrey,
                              size: 34.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  showDropDown
                      ? Container(
                          width: deviceWidth * 0.56,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                                  List.generate(fundTypes.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    //loading = true;
                                    setState(() {});
                                    fundType = fundTypes[index];
                                    showDropDown = false;

                                    if (fundType != 'Choose Currency') {
                                      convertable = true;
                                    } else {
                                      convertable = false;
                                    }
                                    fetchRates().then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      width: deviceWidth * 0.66,
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          // border: Border.all(
                                          //   color: Colors.red[500],
                                          // ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Text(
                                        '${fundTypes[index]}',
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: 'Muli',
                                            fontWeight: FontWeight.w600),
                                      )),
                                );
                              })))
                      : SizedBox(
                          height: 0,
                        ),
                  fundType == 'NGN'
                      ? CalculateFundingForm(
                          rate: ngn,
                          convertable: convertable,
                          region: fundType,
                          data: widget.cardDetails,
                          email: widget.email,
                        )
                      : fundType == 'GBP'
                          ? CalculateFundingForm(
                              rate: uk,
                              convertable: convertable,
                              region: fundType,
                              data: widget.cardDetails,
                              email: widget.email,
                            )
                          : CalculateFundingForm(
                              rate: usd,
                              convertable: convertable,
                              region: fundType,
                              data: widget.cardDetails,
                              email: widget.email,
                            )
                ],
              ),
            ))
          ],
          //children: [HeaderBack(), ProfileHeader(), PullUpCardProfile()],
        ));
  }
}

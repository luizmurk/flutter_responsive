import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:outlook/styleSheet.dart';

class AllInvestmentsHistoryListCard extends StatelessWidget {
  final dynamic data;

  const AllInvestmentsHistoryListCard({Key key, this.data});
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        width: deviceWidth * 0.9,
        margin: EdgeInsets.only(left: 0, top: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: white.withOpacity(0.8),
            // border: Border.all(
            //   color: Colors.red[500],
            // ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Countup(
              begin: 0,
              end: data['amount_invested'].toDouble(),
              prefix: new String.fromCharCodes(new Runes('\u0024')),
              duration: Duration(seconds: 3),
              separator: ',',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 20, fontFamily: numbers, color: border),
            ),
            Row(
              children: [
                Text(
                  '+',
                  style: TextStyle(
                      fontSize: 15, fontFamily: numbers, color: Colors.orange),
                ),
                Countup(
                  begin: 0,
                  end: data['interest_amount'].toDouble(),
                  prefix: new String.fromCharCodes(new Runes('\u0024')),
                  duration: Duration(seconds: 3),
                  separator: ',',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, fontFamily: numbers, color: Colors.orange),
                ),
                Text(
                  '(${data['interest']})',
                  style: TextStyle(
                      fontSize: 15, fontFamily: numbers, color: Colors.orange),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Countup(
              begin: 0,
              end: data['roic'].toDouble(),
              prefix: new String.fromCharCodes(new Runes('\u0024')),
              duration: Duration(seconds: 3),
              separator: ',',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: numbers,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Investment Date : ${data['date_of_investment']}',
              style: TextStyle(
                  fontSize: 12, color: Colors.grey, fontFamily: 'Droid Sans'),
            ),
            Text(
              'Due Date : ${data['due_date']}',
              style: TextStyle(
                  fontSize: 12, color: Colors.grey, fontFamily: 'Droid Sans'),
            ),
          ],
        ));
  }
}

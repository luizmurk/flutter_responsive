import 'package:flutter/material.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/styleSheet.dart';

class ActiveInvests extends StatelessWidget {
  final dynamic date;
  final int amount;
  final String type;
  final String typeDetails;

  const ActiveInvests(
      {Key key, this.date, this.amount, this.type, this.typeDetails});
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return (!Responsive.isMobile(context))
        ? Container(
            width: deviceWidth * 0.5,
            margin: EdgeInsets.only(left: 15, top: 15),
            decoration: BoxDecoration(
                color: white,
                // border: Border.all(
                //   color: Colors.red[500],
                // ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        // border: Border.all(
                        //   color: Colors.red[500],
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$500.00',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '25th January, 2020',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Text(
                          'Lumy Gold Plan',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ))
        : Container(
            width: deviceWidth * 0.5,
            margin: EdgeInsets.only(left: 15, top: 15),
            decoration: BoxDecoration(
                color: white,
                // border: Border.all(
                //   color: Colors.red[500],
                // ),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        // border: Border.all(
                        //   color: Colors.red[500],
                        // ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$500.00',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '25th January, 2020',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        Text(
                          'Lumy Gold Plan',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}

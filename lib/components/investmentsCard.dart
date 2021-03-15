import 'package:flutter/material.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/styleSheet.dart';

class InvestmentsCard extends StatelessWidget {
  final dynamic date;
  final int amount;
  final String type;
  final String typeDetails;

  const InvestmentsCard(
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
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '25th January, 2021',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Lumy Gold Plan',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Acumin',
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '180% ROI',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Text(
                          '10 Months',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
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
                          '1,430.00',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Container(
                          child: Text(
                            '+1,000.00 (20% per Circle)',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Text(
                          '1,430.00',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Due: 21st May 2020',
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '25th January, 2021',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        Text(
                          'Lumy Gold Plan',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Acumin',
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '180% ROI',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          '10 Months',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
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
                          '1,430.00',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        Container(
                          child: Text(
                            '+1,000.00 (20% per Circle)',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Text(
                          '1,430.00',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Due: 21st May 2020',
                          style: TextStyle(fontSize: 9, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}

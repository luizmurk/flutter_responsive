import 'package:flutter/material.dart';
import 'package:outlook/styleSheet.dart';
import 'package:countup/countup.dart';

class ListCard extends StatelessWidget {
  final dynamic date;
  final dynamic amount;
  final String type;
  final String typeDetails;
  final String filter;

  const ListCard(
      {Key key,
      this.date,
      this.amount,
      this.type,
      this.typeDetails,
      this.filter});
  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    var doublee = amount.toDouble();
    return filter == 'All'
        ? Container(
            child: type == 'credit'
                ? Container(
                    height: deviceHeight * 0.12,
                    width: deviceWidth * 1,
                    padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: white,
                        // border: Border(
                        //   left:
                        //       BorderSide(width: 6.0, color: Colors.lightBlue.shade600),
                        // ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55.0),
                          bottomRight: Radius.circular(55.0),
                          topLeft: Radius.circular(25.0),
                        )),
                    //borderRadius: BorderRadius.all(Radius.circular(10))

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            transactionTextDate('$date'),
                            Countup(
                              begin: 0,
                              end: doublee,
                              prefix:
                                  new String.fromCharCodes(new Runes('\u0024')),
                              duration: Duration(seconds: 3),
                              separator: ',',
                              textAlign: TextAlign.center,
                              style: transcPrize(),
                            ),
                            transactionDateText(typeDetails),
                            transactionDateText(type),
                          ],
                        ),
                      ],
                    ))
                : Container(
                    height: deviceHeight * 0.12,
                    width: deviceWidth * 1,
                    padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: white,
                        // border: Border(
                        //   left:
                        //       BorderSide(width: 6.0, color: Colors.lightBlue.shade600),
                        // ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55.0),
                          bottomLeft: Radius.circular(55.0),
                          topRight: Radius.circular(25.0),
                        )),
                    //borderRadius: BorderRadius.all(Radius.circular(10))

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        transactionTextDate('$date'),
                        Countup(
                          begin: 0,
                          end: doublee,
                          prefix: new String.fromCharCodes(new Runes('\u0024')),
                          duration: Duration(seconds: 3),
                          separator: ',',
                          textAlign: TextAlign.center,
                          style: debtPrize(),
                        ),
                        transactionDateText(typeDetails),
                        transactionDateText(type),
                      ],
                    )),
          )
        : filter == 'Credit Only' && type == 'credit'
            ? Container(
                height: deviceHeight * 0.12,
                width: deviceWidth * 1,
                padding: EdgeInsets.fromLTRB(20, 10, 5, 10),
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: white,
                    // border: Border(
                    //   left:
                    //       BorderSide(width: 6.0, color: Colors.lightBlue.shade600),
                    // ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(55.0),
                      bottomRight: Radius.circular(55.0),
                      topLeft: Radius.circular(25.0),
                    )),
                //borderRadius: BorderRadius.all(Radius.circular(10))

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        transactionTextDate('$date'),
                        Countup(
                          begin: 0,
                          end: doublee,
                          prefix: new String.fromCharCodes(new Runes('\u0024')),
                          duration: Duration(seconds: 3),
                          separator: ',',
                          textAlign: TextAlign.center,
                          style: transcPrize(),
                        ),
                        transactionDateText(typeDetails),
                        transactionDateText(type),
                      ],
                    ),
                  ],
                ))
            : filter == 'Debit Only' && type == 'debit'
                ? Container(
                    height: deviceHeight * 0.12,
                    width: deviceWidth * 1,
                    padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        color: white,
                        // border: Border(
                        //   left:
                        //       BorderSide(width: 6.0, color: Colors.lightBlue.shade600),
                        // ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55.0),
                          bottomLeft: Radius.circular(55.0),
                          topRight: Radius.circular(25.0),
                        )),
                    //borderRadius: BorderRadius.all(Radius.circular(10))

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        transactionTextDate('$date'),
                        Countup(
                          begin: 0,
                          end: doublee,
                          prefix: new String.fromCharCodes(new Runes('\u0024')),
                          duration: Duration(seconds: 3),
                          separator: ',',
                          textAlign: TextAlign.center,
                          style: debtPrize(),
                        ),
                        transactionDateText(typeDetails),
                        transactionDateText(type),
                      ],
                    ))
                : SizedBox(
                    height: 0,
                  );
  }
}

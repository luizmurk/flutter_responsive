import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/responsive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({Key key, this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  saveData(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('availableBalance', data['availableBalance']);
    prefs.setString('userID', data['userID']);
    prefs.setString('userDocId', '4W6tKs8VbcgTrljT1D5d');
  }

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<DocumentSnapshot>(
        future: userCredentials.doc("4W6tKs8VbcgTrljT1D5d").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            print('dash data here');
            print(data);
            saveData(data);
            return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: !Responsive.isMobile(context)
                    ? Row(
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                scaffoldKey.currentState.openDrawer();
                              },
                            ),
                          if (!Responsive.isMobile(context))
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available Balance',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        color: Colors.black45),
                                  ),
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: userCredentials
                                        .doc("4W6tKs8VbcgTrljT1D5d")
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text("Loading");
                                      }
                                      var creds = snapshot.data.data();
                                      print('creds here');
                                      print(creds);
                                      return Text(
                                        '\$${creds['availableBalance']}',
                                        style: TextStyle(
                                            fontSize: 45,
                                            //fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          Spacer(),
                          Container(
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${data['username']}',
                                          style: TextStyle(
                                              fontFamily: 'Varela Round',
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${data['email']}',
                                          style: TextStyle(
                                              fontFamily: 'Varela Round',
                                              fontSize: 9,
                                              color: Colors.black45),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage("assets/images/user_3.png"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (!Responsive.isDesktop(context))
                                IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed: () {
                                    scaffoldKey.currentState.openDrawer();
                                  },
                                ),
                              if (!Responsive.isMobile(context))
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Available Balance',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                            color: Colors.black45),
                                      ),
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: userCredentials
                                            .doc("4W6tKs8VbcgTrljT1D5d")
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return Text('Something went wrong');
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Text("Loading");
                                          }
                                          var creds = snapshot.data.data();
                                          print('creds here');
                                          print(creds);
                                          return Text(
                                            '\$${creds['availableBalance']}',
                                            style: TextStyle(
                                                fontSize: 45,
                                                //fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              Spacer(),
                              Container(
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${data['username']}',
                                              style: TextStyle(
                                                  fontFamily: 'Varela Round',
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '${data['email']}',
                                              style: TextStyle(
                                                  fontFamily: 'Varela Round',
                                                  fontSize: 9,
                                                  color: Colors.black45),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 15),
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                            "assets/images/user_3.png"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 65),
                          StreamBuilder<DocumentSnapshot>(
                            stream: userCredentials
                                .doc("4W6tKs8VbcgTrljT1D5d")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              var creds = snapshot.data.data();
                              print('creds here');
                              print(creds);
                              return Text(
                                '\$${creds['availableBalance']}',
                                style: TextStyle(
                                    fontSize: 45,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              );
                            },
                          )
                        ],
                      ));
          }
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:outlook/components/side_menu.dart';
import 'package:outlook/components/side_menu_item.dart';
import 'package:outlook/models/Email.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/screens/email/TrackingUpdtesPane.dart';
import 'package:outlook/screens/email/contactsPane.dart';
import 'package:outlook/screens/email/customersPane.dart';
import 'package:outlook/screens/email/shipmentsPane.dart';
import 'package:outlook/screens/main/components/contacts.dart';
import 'package:outlook/screens/main/components/shipments.dart';
import 'package:outlook/screens/main/components/trackingUpdates.dart';
import '../../constants.dart';
import 'components/customers.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int view = 1;
  int qoutesIndex = 0;
  int shipmentIndex = 0;
  int trackingIndex = 0;
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('qoutesRequest').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data.docs.isEmpty) {
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: 85,
                ),
                Icon(
                  Icons.app_blocking,
                  color: Colors.grey,
                  size: 35.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                Text(
                  'You\'ve not made any transaction',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ));
          }
          print('your docs');
          print(snapshot.data.docs);
          return new Responsive(
            // Let's work on our mobile part
            mobile: ListOfEmails(
              press: () {},
            ),
            tablet: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ListOfEmails(
                    press: () {},
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: EmailScreen(),
                ),
              ],
            ),
            desktop: Row(
              children: [
                // Once our width is less then 1300 then it start showing errors
                // Now there is no error if our width is less then 1340
                Expanded(
                  flex: _size.width > 1340 ? 2 : 4,
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
                    color: kBgLightColor,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/Logo Outlook.png",
                                  width: 46,
                                ),
                                Spacer(),
                                // We don't want to show this close button on Desktop mood
                                if (!Responsive.isDesktop(context))
                                  CloseButton(),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            // Menu Items
                            SideMenuItem(
                              press: () {
                                setState(() {
                                  view = 1;
                                });
                              },
                              title: "Customers",
                              iconSrc: "assets/Icons/Inbox.svg",
                              isActive: true,
                              itemCount: 3,
                              showBorder: false,
                            ),
                            SideMenuItem(
                              press: () {
                                setState(() {
                                  view = 2;
                                });
                              },
                              title: "Shipments",
                              iconSrc: "assets/Icons/Send.svg",
                              isActive: false,
                              showBorder: false,
                            ),
                            SideMenuItem(
                              press: () {
                                setState(() {
                                  view = 3;
                                });
                              },
                              title: "Tracking Updates",
                              iconSrc: "assets/Icons/File.svg",
                              isActive: false,
                              showBorder: false,
                            ),
                            SideMenuItem(
                              press: () {
                                setState(() {
                                  view = 4;
                                });
                              },
                              title: "Contacts",
                              iconSrc: "assets/Icons/Trash.svg",
                              isActive: false,
                              showBorder: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: view == 1
                      ? ListOfEmails(
                          press: () {},
                        )
                      : view == 2
                          ? Shipments(
                              press: () {},
                            )
                          : view == 3
                              ? TrackingUpdates(
                                  press: () {},
                                )
                              : view == 4
                                  ? Contacts()
                                  : SizedBox(),
                ),
                Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: view == 1
                      ? EmailScreen(
                          email: emails[0],
                        )
                      : view == 2
                          ? ShipmentsPane(
                              email: emails[0],
                            )
                          : view == 3
                              ? TrackingUpdatesPane(
                                  email: emails[0],
                                )
                              : view == 4
                                  ? ContactsPane()
                                  : SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

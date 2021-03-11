import 'package:flutter/material.dart';
import 'package:outlook/components/desktopSideMenu.dart';
import 'package:outlook/components/sideMenu.dart';
import 'package:outlook/responsive.dart';
import 'package:outlook/screens/email/DisplayScreen.dart';
import 'components/list_of_emails.dart';

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // It provide us the width and height
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: AppSideMenu(),
      ),
      body: Responsive(
        // Let's work on our mobile part
        mobile: ListOfEmails(),
        tablet: Row(
          children: [
            Expanded(
              flex: 9,
              child: DisplayScreen(
                scaffoldKey: scaffoldKey,
              ),
            ),
          ],
        ),
        desktop: Row(
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            Expanded(
              flex: 4,
              child: DesktopSideMenu(),
            ),
            Expanded(
              flex: 11,
              child: DisplayScreen(
                scaffoldKey: scaffoldKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

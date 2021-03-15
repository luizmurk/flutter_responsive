import 'package:flutter/material.dart';
import 'package:outlook/data_management/databases.dart';
import 'package:outlook/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class AppSideMenu extends StatefulWidget {
  const AppSideMenu({
    Key key,
  }) : super(key: key);

  @override
  _AppSideMenuState createState() => _AppSideMenuState();
}

class _AppSideMenuState extends State<AppSideMenu> {
  String selectTitle = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //selectTitle = 'Dashboard';
    uiComponents
        .doc('view')
        .update({'slot': 1})
        .then((value) {})
        .catchError((error) {});
  }

  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: whiteBg,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/splash.png",
                    width: 46,
                  ),
                  Spacer(),
                  // We don't want to show this close button on Desktop mood
                  if (!Responsive.isDesktop(context)) CloseButton(),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              SizedBox(height: kDefaultPadding),
              SideMenuItem(
                title: 'Dashboard',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Dashboard';
                    uiComponents.doc('view').update({'slot': 1}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'Invest Funds',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Invest Funds';
                    uiComponents.doc('view').update({'slot': 2}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'Fund Wallet',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Fund Wallet';
                    uiComponents.doc('view').update({'slot': 3}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'Withdraw Funds',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Withdraw Funds';
                    uiComponents.doc('view').update({'slot': 4}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'Transaction History',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Transaction History';
                    uiComponents.doc('view').update({'slot': 5}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'Investment History',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Investment History';
                    uiComponents.doc('view').update({'slot': 6}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              ),
              SideMenuItem(
                title: 'FAQ',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'FAQ';
                    uiComponents.doc('view').update({'slot': 7}).then((value) {
                      //goToReplacement(DrawFundsPage(), context);
                    }).catchError((error) {});
                  });
                },
                iconSrc: 'assets/Icons/Inbox.svg',
              )
            ],
          ),
        ),
      ),
    );
  }
}

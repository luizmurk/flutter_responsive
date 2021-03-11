import 'package:flutter/material.dart';
import 'package:outlook/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';
import 'tags.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class DesktopSideMenu extends StatefulWidget {
  const DesktopSideMenu({
    Key key,
  }) : super(key: key);

  @override
  _DesktopSideMenuState createState() => _DesktopSideMenuState();
}

class _DesktopSideMenuState extends State<DesktopSideMenu> {
  String selectTitle = '';
  @override
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
                    "assets/images/Logo Outlook.png",
                    width: 46,
                  ),
                  Spacer(),
                  // We don't want to show this close button on Desktop mood
                  if (!Responsive.isDesktop(context)) CloseButton(),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              SideMenuItem(
                title: 'Dashboard',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Dashboard';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'Invest Funds',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Invest Funds';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'Fund Wallet',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Fund Wallet';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'Withdraw Funds',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Withdraw Funds';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'Transaction History',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Transaction History';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'Investment History',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'Investment History';
                  });
                },
                iconSrc: '',
              ),
              SideMenuItem(
                title: 'FAQ',
                activeTitle: selectTitle,
                press: () {
                  print('pressed');
                  setState(() {
                    selectTitle = 'FAQ';
                  });
                },
                iconSrc: '',
              )
            ],
          ),
        ),
      ),
    );
  }
}

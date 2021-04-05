import 'package:flutter/material.dart';
import 'package:outlook/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import '../extensions.dart';
import 'side_menu_item.dart';
import 'tags.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
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
              // Menu Items
              SideMenuItem(
                press: () {},
                title: "Customers",
                iconSrc: "assets/Icons/Inbox.svg",
                isActive: true,
                itemCount: 3,
              ).addNeumorphism(),
              SideMenuItem(
                press: () {},
                title: "updates",
                iconSrc: "assets/Icons/Send.svg",
                isActive: false,
              ).addNeumorphism(),
              SideMenuItem(
                press: () {},
                title: "Tracking Updates",
                iconSrc: "assets/Icons/File.svg",
                isActive: false,
              ).addNeumorphism(),
              SideMenuItem(
                press: () {},
                title: "Contacts",
                iconSrc: "assets/Icons/Trash.svg",
                isActive: false,
                showBorder: false,
              ).addNeumorphism(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:outlook/responsive.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({Key key, this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    dynamic deviceWidth;
    dynamic deviceHeight;
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
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
                    Text(
                      '\$20,000.00',
                      style: TextStyle(
                          fontSize: 45,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Will Odia',
                            style: TextStyle(
                                fontFamily: 'Varela Round',
                                fontSize: 12,
                                color: Colors.black),
                          ),
                          Text(
                            'will4odia@gmail.com',
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
                      backgroundImage: AssetImage("assets/images/user_3.png"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

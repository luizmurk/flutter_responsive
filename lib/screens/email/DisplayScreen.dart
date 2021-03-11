import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outlook/models/Email.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';
import 'components/header.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({Key key, this.email, this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  final Email email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Header(
                    scaffoldKey: scaffoldKey,
                  )),
              Divider(thickness: 1),
              Expanded(
                  flex: 13,
                  child: Center(
                    child: Text('Control Panel'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MediaSizing {
  dynamic deviceHeight;
  dynamic deviceWidth;
  MediaQuery orientation;
  BuildContext context;
  double value;

  MediaSizing({
    Key key,
    @required deviceHeight,
    @required deviceWidth,
    @required value,
  });

  getWidth() {
    return deviceWidth * value;
  }

  getHeight() {
    return deviceHeight * value;
  }
}

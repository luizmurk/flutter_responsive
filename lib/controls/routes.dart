import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

goTo(Widget page, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

goToResponse(Widget page, Widget fromPage, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  ).then((_) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return fromPage;
        },
      ),
    );
  });
}

goToReplacement(Widget page, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

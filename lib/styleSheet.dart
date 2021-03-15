import 'package:flutter/material.dart';

final primary = const Color(0xFF6EDBE7);
final white = const Color(0xFFFFFFFF);
final green = const Color(0xFF006d77);
final orange = const Color(0xFFf6f4d2);
final whiteText = const Color(0xFFf7ede2);
final blacktext = const Color(0xFF191919);
final darkgrey = Colors.black;
final grey = Colors.grey;
final border = const Color(0xFF98c1d9);
final colorblack = const Color(0xFF394047);
final red = const Color(0xFFFF3737);
//final scaffoldColor = const Color(0xFF03045e);
final scaffoldColor = const Color(0xFFffffff);
final pullUpCardColor = Colors.lightBlue.withOpacity(0.1);

final numbers = 'ABeeZee';

// Text Components

Text sectionHeader(String text) {
  return Text(
    text,
    style: sectionLabels(),
  );
}

Text buttonTextReal(String text) {
  return Text(
    text,
    style: homeButtonLabelsReal(),
  );
}

Text transactionAmountTextDebit(String text) {
  return Text(
    text,
    style: transactionAmountLabelDebit(),
  );
}

Text transactionAmountTextCredit(String text) {
  return Text(
    text,
    style: transactionAmountLabelCredit(),
  );
}

Text transactionDateText(String text) {
  return Text(
    text,
    style: transactionDateLabel(),
  );
}

Text transactionTextDate(String text) {
  return Text(
    text,
    style: transactionTextDateLabel(),
  );
}

Text buttonText(String text) {
  return Text(
    text,
    style: homeButtonLabels(),
  );
}

Text dropDownText(String text) {
  return Text(
    text,
    textAlign: TextAlign.right,
    style: dropdownLabels(),
  );
}

//..................................poppinsMedium ....................................

TextStyle inputTextStyle() {
  return TextStyle(
      fontWeight: FontWeight.w200,
      fontSize: 13.0,
      color: grey,
      fontFamily: 'ABeeZee',
      letterSpacing: 2.0);
}

TextStyle blueTextStyle() {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15.0,
      color: white,
      fontFamily: 'Muli',
      letterSpacing: 2.0);
}

TextStyle menuLabel() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    color: darkgrey,
    fontFamily: 'Droid Sans',
  );
}

TextStyle balanceLabels() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 7.0,
    color: Colors.black,
    fontFamily: 'ABeeZee',
  );
}

TextStyle balanceLabels2() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    color: Colors.black,
    fontFamily: 'ABeeZee',
  );
}

TextStyle dropdownLabels() {
  return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15.0,
      color: darkgrey,
      fontFamily: 'Droid Sans',
      letterSpacing: 1.0);
}

TextStyle homeButtonLabelsReal() {
  return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20.0,
      color: white,
      fontFamily: 'Droid Sans',
      letterSpacing: 2.0);
}

TextStyle transactionTextDateLabel() {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 10.0,
      color: darkgrey,
      fontFamily: 'Roboto',
      letterSpacing: 2.0);
}

TextStyle transactionDateLabel() {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12.0,
      color: Colors.grey,
      fontFamily: 'Droid Sans',
      letterSpacing: 2.0);
}

TextStyle transactionAmountLabelCredit() {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 17.0,
      color: Colors.lightGreen,
      fontFamily: 'Droid Sans',
      letterSpacing: 2.0);
}

TextStyle transactionAmountLabelDebit() {
  return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 13.0,
      color: red,
      fontFamily: 'Droid Sans',
      letterSpacing: 2.0);
}

TextStyle homeButtonLabels() {
  return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15.0,
      color: white,
      fontFamily: 'Muli',
      letterSpacing: 2.0);
}

TextStyle sectionLabels() {
  return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15.0,
      color: white,
      fontFamily: 'Muli',
      letterSpacing: 2.5);
}

TextStyle transcPrize() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: green,
    fontFamily: numbers,
  );
}

TextStyle debtPrize() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: red,
    fontFamily: numbers,
  );
}

TextStyle walletPrize2() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 65.0,
    color: green,
    fontFamily: numbers,
  );
}

TextStyle walletPrize() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 25.0,
    color: green,
    fontFamily: numbers,
  );
}

TextStyle hintStylemediumblacktextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Color(0xFF0C0D0E).withOpacity(0.79),
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStyleblacktextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: Color(0xFF0C0D0E).withOpacity(0.58),
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylewhiteTextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: whiteText,
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylewhitetextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: Colors.white,
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStyleredsmalltextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 9.0,
    color: Color(0xFFFF3737),
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylewhitesmalltextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylesmallbtextPM() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 11.0,
    color: blacktext.withOpacity(0.60),
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylesblackPM() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Color(0xFF0C0D0E),
    fontFamily: 'PoppinsMedium',
  );
}

TextStyle hintStylesblacktextPM() {
  return TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: blacktext,
    fontFamily: 'PoppinsMedium',
  );
}
//..................................poppinsSemiBold ....................................

TextStyle hintStylewhitetextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: Colors.white,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStylegreentextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15.0,
    color: green,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStylesmalltextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 13.0,
    color: blacktext,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStyleblacktextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17.0,
    color: Colors.black,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStyleblackatextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17.0,
    color: blacktext,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStyleboldwhitePSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17.0,
    color: Colors.white,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStyleboldtextPSB() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: blacktext,
    fontFamily: 'PoppinsSemiBold',
  );
}

TextStyle hintStyleboldtextPSBopacity() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: blacktext.withOpacity(0.65),
    fontFamily: 'PoppinsSemiBold',
  );
}
//..................................poppinsRegular ....................................

TextStyle hintStylesmallprimaryPR() {
  return TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
    color: primary,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmallblackPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: blacktext,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmallbluePR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Color(0xFF06AAFF),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmallwhitePR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.white,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmallerwhitePR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylewhitePR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Colors.white.withOpacity(0.87),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleblackPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: blacktext.withOpacity(0.60),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleredPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Color(0xFFFF3737),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleBlackPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: blacktext.withOpacity(0.60),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmBlackPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 11.0,
    color: Color(0xFF0C0D0E).withOpacity(0.60),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmBlackbPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
    color: Color(0xFF0C0D0E).withOpacity(0.51),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleSmPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: Color(0xFF0C0D0E).withOpacity(0.51),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmallrPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: Color(0xFFf9571C),
    decoration: TextDecoration.lineThrough,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmBlackboldPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 19.0,
    color: Color(0xFF0C0D0E),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmBlackmediumPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Color(0xFF0C0D0E),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleWhitemediumPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylesmBlackamediumPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Color(0xFF0C0D0E).withOpacity(0.62),
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStyleBlackmediumPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17.0,
    color: Colors.black,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylebtextPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13.0,
    color: blacktext,
    fontFamily: 'PoppinsRegular',
  );
}

TextStyle hintStylebatextPR() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: blacktext,
    fontFamily: 'PoppinsRegular',
  );
}

//..................................poppinsLight ....................................
TextStyle hintStyleswhiteaPL() {
  return TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 12.0,
    color: Colors.white.withOpacity(0.82),
    fontFamily: 'PoppinsLight',
  );
}

TextStyle hintStylesblackaPL() {
  return TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 12.0,
    color: Color(0xFF0C0D0E).withOpacity(0.82),
    fontFamily: 'PoppinsLight',
  );
}

//..................................MontserratRegular ....................................

TextStyle hintStylemontserratRegular() {
  return TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
    color: Color(0xFF8B8B8B).withOpacity(0.75),
    fontFamily: 'MontserratRegular',
  );
}

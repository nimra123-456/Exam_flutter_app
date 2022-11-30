import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:exam_app/constants/constants.dart';

class Styles {
  Styles._();

  //General

  static TextStyle heading() {
    return TextStyle(fontSize: 36, color: kBlackColor);
  }

  static TextStyle headline1() {
    return TextStyle(fontSize: 26, color: kBlackColor);
  }

  static TextStyle headline2() {
    return TextStyle(fontSize: 24, color: kBlackColor);
  }

  static TextStyle headline3() {
    return TextStyle(fontSize: 22, color: kBlackColor);
  }

  static TextStyle headline4() {
    return TextStyle(fontSize: 20, color: kBlackColor);
  }

  static TextStyle headline5() {
    return TextStyle(fontSize: 18, color: kBlackColor);
  }

  static TextStyle headline6() {
    return TextStyle(fontSize: 16, color: kBlackColor);
  }

  static TextStyle bodyText1() {
    return TextStyle(fontSize: 14, color: kBlackColor);
  }

  static TextStyle bodyText2() {
    return TextStyle(fontSize: 12, color: kBlackColor);
  }

  static TextStyle subtitle1() {
    return TextStyle(fontSize: 10, color: kBlackColor);
  }

  static TextStyle subtitle2() {
    return TextStyle(fontSize: 8, color: kBlackColor);
  }

// bold headings

  static TextStyle headlineBold4() {
    return TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: kBlackColor);
  }

  static TextStyle headlineBold5() {
    return TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: kBlackColor);
  }

  static TextStyle headlineBold6() {
    return TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: kBlackColor);
  }

  static TextStyle bodyTextBold1() {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: kBlackColor);
  }

  static TextStyle bodyTextBold2() {
    return TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: kBlackColor);
  }
}

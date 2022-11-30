import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamRepo {
  static clearPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  static showSnack(context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$text"),
    ));
  }
}

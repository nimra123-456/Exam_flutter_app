import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/screens/login_option.dart';
import 'package:exam_app/screens/student/welcome_screen.dart';
import 'package:exam_app/screens/teacher/teacher_home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userRole = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userRole = (prefs.getString('role') ?? "");
    print(_userRole);
    if (_userRole == "") {
      Get.offAll(() => LoginOptionScreen());
    } else {
      User.MY_USER = User.fromPrefs(prefs);
      Timer(
          Duration(seconds: 3),
          () => _userRole == "Teacher"
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TeacherHomePage()))
              : Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          child: SpinKitSquareCircle(
            size: 60,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

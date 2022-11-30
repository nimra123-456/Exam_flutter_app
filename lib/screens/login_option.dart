import 'package:flutter/material.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/screens/student/login_page.dart';
import 'package:exam_app/screens/teacher/teacher_login.dart';

class LoginOptionScreen extends StatefulWidget {
  @override
  _LoginOptionScreenState createState() => _LoginOptionScreenState();
}

class _LoginOptionScreenState extends State<LoginOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/forgot.png"),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Log In As",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),),
                      onPressed: () async {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (contetx) => LoginPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Student",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                    style:ElevatedButton.styleFrom(  backgroundColor: kColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),),
                      onPressed: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (contetx) => TeacherLoginPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Teacher",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/screens/student/forgotpassword.dart';
import 'package:exam_app/screens/student/welcome_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String uname = "masif@gmail.com";
  // String pass = "123456789";
  String uname = "";
  String pass = "";
  late String url;
  bool isLoading = false;
  bool _isObscureText = true;

  void toggle() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 400),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          initialValue: uname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your email";
                            }
                            if (!RegExp(email_RegExp).hasMatch(value)) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              hintText: "email",
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            setState(() {
                              uname = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          initialValue: pass,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter your password";
                            } else
                              return null;
                          },
                          obscureText: _isObscureText,
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              filled: true,
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                  icon: Icon(!_isObscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    toggle();
                                  }),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          onChanged: (val) {
                            setState(() {
                              pass = val;
                            });
                          },
                        ),
                      ),
                      Hero(
                        tag: "FOR",
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => ForgotPassword());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton(
                           style:ElevatedButton.styleFrom( 
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await login();

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> _queryParameters = <String, String>{
      'email': uname,
      "role": "Student",
      "password": pass,
    };

    var response = await http.get(
      Uri.http(BASE_URL, '/api/login', _queryParameters),
    );

    if (response.statusCode == 200) {
      if (json.decode(response.body)["status"] == 1) {
        User user = User.fromJson(jsonDecode(response.body)["data"]);
        prefs.setInt("id", user.id);
        prefs.setString("name", user.name ?? '');
        prefs.setString("rollno", user.rollno ?? '');
        prefs.setString("image", user.image ?? '');
        prefs.setString("email", user.email ?? '');
        prefs.setString("cnic", user.cnic ?? '');
        prefs.setString("no", user.no ?? '');
        prefs.setString("address", user.address ?? '');
        prefs.setString("role", user.role ?? '');
        Get.offAll(() => WelcomeScreen());
      }
    } else {
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    }
  }
}

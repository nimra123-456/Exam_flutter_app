import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/screens/student/set_new_password.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String uname;
  late String phone;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String newPasswordText = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Container(
                      height: 300,
                      child: Hero(
                          tag: "FOR",
                          child: Image.asset('assets/images/forgot.png'))),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email.";
                            }
                            if (!RegExp(email_RegExp).hasMatch(value)) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              labelText: "email",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
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
                          autofillHints: [AutofillHints.telephoneNumber],
                          validator: (value) {
                            if (value!.length != 11)
                              return "Mobile number should be 11 digits.";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              filled: true,
                              labelText: "Phone Number",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: Icon(
                                Icons.phone,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
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
                                await fogotPassword();

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Reset Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
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

  fogotPassword() async {
    final Map<String, String> _queryParameters = <String, String>{
      'email': uname,
      'no': phone,
    };

    var response = await http.get(
      Uri.https(BASE_URL, 'api/forget', _queryParameters),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SetNewPassword(email: uname)));
    } else {
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    }
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';

class SetNewPassword extends StatefulWidget {
  final email;

  SetNewPassword({this.email});

  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  late String password;
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
          "Set New Password",
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
                          readOnly: true,
                          initialValue: widget.email,
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              labelText: "Email",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email_rounded,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value!.length <= 5)
                              return "password should be more than 5 characters or digits.";
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              fillColor: Color(
                                0x11304ffe,
                              ),
                              filled: true,
                              labelText: "New Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50),
                              )),
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.9,
                          // ignore: deprecated_member_use
                          child: ElevatedButton(
                            style:ElevatedButton.styleFrom( 
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await saveNewPassword();

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                "Save Password",
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

  saveNewPassword() async {
    final Map<String, String> _queryParameters = <String, String>{
      'email': widget.email,
      'password': password,
    };

    var response = await http.post(
      Uri.parse(API_BASE_URL + "forget"),
      body: _queryParameters,
    );
    print(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    } else {
      ExamRepo.showSnack(context, json.decode(response.body)["message"]);
    }
  }
}

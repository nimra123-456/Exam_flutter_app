import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';

class TrueFalseScreen extends StatefulWidget {
  const TrueFalseScreen({Key? key}) : super(key: key);

  @override
  _TrueFalseScreenState createState() => _TrueFalseScreenState();
}

class _TrueFalseScreenState extends State<TrueFalseScreen> {
  TextEditingController question = TextEditingController();
  bool isTrue = true;
  dynamic argumentData = getx.Get.arguments;

  @override
  void initState() {
    super.initState();
  }

  List PaperQuestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True False Paper"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: question,
                  cursorColor: kColor,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Question";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      fillColor: Color(
                        0x11304ffe,
                      ),
                      filled: true,
                      hintText: "Enter Question Statement ...",
                      hintStyle: Styles.headlineBold5(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isTrue = true;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kGreenColor),
                        child: Center(
                          child: isTrue
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.white,
                                )
                              : Container(
                                  child: Text(""),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "True",
                      style: Styles.headlineBold6(),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isTrue = false;
                        });
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kRedColor),
                        child: Center(
                          child: isTrue == false
                              ? Icon(
                                  Icons.check,
                                  size: 20,
                                  color: Colors.white,
                                )
                              : Container(
                                  child: Text(""),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "False",
                      style: Styles.headlineBold6(),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                  style:ElevatedButton.styleFrom( backgroundColor: kGreenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),),
                      onPressed: () {
                        var productMap = {
                          'statement': question.text,
                          'answer': isTrue.toString(),
                        };
                        PaperQuestions.add(productMap);
                        setState(() {
                          question.clear();
                          isTrue = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                     style:ElevatedButton.styleFrom( backgroundColor: kColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),),
                      onPressed: () {
                        if (PaperQuestions.length != 0) {
                          uploadQuestions();
                        } else {
                          ExamRepo.showSnack(context, "No Question Added");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  uploadQuestions() async {
    var formData = FormData.fromMap({
      "session_id": argumentData[0]['first'],
      "subject_id": argumentData[1]['second'],
      "marks": argumentData[2]['third'],
      "time": argumentData[3]['fourth'],
      "teacher_id": User.MY_USER.id.toString(),
      "tf": PaperQuestions
    });
    var response = await Dio()
        .post(API_BASE_URL + "save-paper", data: formData)
        .then((onResponse) async {
      if (onResponse.statusCode == 200) {
        PaperQuestions.clear();
        ExamRepo.showSnack(context, "paper successfully submitted");
      } else {
        ExamRepo.showSnack(context, "error occur");
      }
    }).onError((error, stackTrace) {
      ExamRepo.showSnack(context, "Paper Already Submitted");
    });
    ;
  }
}

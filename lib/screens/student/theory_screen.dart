import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/student_exam_paper_controller.dart';
import 'package:exam_app/widgets/paper_completed.dart';

class TheoryScreen extends StatefulWidget {
  const TheoryScreen({Key? key}) : super(key: key);

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  final ExamPaperController ctrl = Get.find();
  final paper_controller = Get.put(ExamPaperController());

  int index = 0;
  int points = 0;
  List PaperQuestions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void nextQuestion() {
    if (index < ctrl.ExamList.theories.length - 1) {
      answer.clear();
      index++;
    } else {
      ctrl.studentAllAnswers = PaperQuestions;
      paper_controller.theoryPapertimeOver();
      ctrl.studentAutoCOmpleteSave();
    }
  }

  TextEditingController answer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ctrl.Theory_paperTimeOver
            ? PaperCompleted()
            : ctrl.ExamList.theories.isEmpty
                ? Container()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: nextQuestion, child: Text("Skip")),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Question",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${index + 1}/${ctrl.ExamList.theories.length}",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            ButtonTheme(
                              child: ElevatedButton(
                                style:ElevatedButton.styleFrom(backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),),
                                onPressed: () async {
                                  PaperQuestions.add(answer.text + "(*)");
                                  nextQuestion();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Save Answer",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          ctrl.ExamList.theories[index].statement + "?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            controller: answer,
                            cursorColor: kColor,
                            maxLines: 50,
                            decoration: InputDecoration(
                                fillColor: Color(
                                  0x11304ffe,
                                ),
                                filled: true,
                                hintText: "Enter your answer ...",
                                hintStyle: Styles.headlineBold5(),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

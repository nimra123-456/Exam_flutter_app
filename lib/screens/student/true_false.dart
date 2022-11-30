import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/student_exam_paper_controller.dart';
import 'package:exam_app/widgets/paper_completed.dart';

class TrueFalseScreen extends StatefulWidget {
  @override
  _TrueFalseScreenState createState() => _TrueFalseScreenState();
}

class _TrueFalseScreenState extends State<TrueFalseScreen>
     {
  final ExamPaperController ctrl = Get.find();
  final paper_controller = Get.put(ExamPaperController());

  int index = 0;
  int points = 0;



  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void nextQuestion() {
    if (index < ctrl.ExamList.tfs.length - 1) {
      index++;
    } else {
      setState(() {
        paper_controller.timeOver();
        ctrl.studentAutoCOmpleteSave();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ctrl.TF_paperTimeOver
            ? PaperCompleted()
            : ctrl.ExamList.tfs.isEmpty?Container():SingleChildScrollView(
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
                    // Container(
                    //     width: double.infinity,
                    //     height: 40,
                    //     decoration: BoxDecoration(
                    //       border:
                    //           Border.all(color: Color(0xFF3F4768), width: 3),
                    //       borderRadius: BorderRadius.circular(50),
                    //     ),
                    //     child: Stack(
                    //       children: [
                    //         // LayoutBuilder provide us the available space for the conatiner
                    //         // constraints.maxWidth needed for our animation
                    //         LayoutBuilder(
                    //           builder: (context, constraints) => Container(
                    //             // from 0 to 1 it takes 60s
                    //             width: constraints.maxWidth * animation.value,
                    //             decoration: BoxDecoration(
                    //               gradient: kPrimaryGradient,
                    //               borderRadius: BorderRadius.circular(50),
                    //             ),
                    //           ),
                    //         ),
                    //         Positioned.fill(
                    //           child: Padding(
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: kDefaultPadding / 2),
                    //             child: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                     "${(animation.value * 60).round()} minutes"),
                    //                 SvgPicture.asset("assets/icons/clock.svg"),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     )),
                    // SizedBox(
                    //   height: kDefaultPadding * 2,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          "${index + 1}/${ctrl.ExamList.tfs.length}",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      ctrl.ExamList.tfs[index].statement + "?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: kDefaultPadding * 5,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              if (ctrl.ExamList.tfs[index].answer ==
                                  "true") {
                                paper_controller.correctQs();
                                nextQuestion();
                              } else {
                                nextQuestion();
                                paper_controller.incorrectQs();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Text(
                                "True",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              if (ctrl.ExamList.tfs[index].answer ==
                                  "false") {
                                nextQuestion();
                                paper_controller.correctQs();
                              } else {
                                nextQuestion();
                                paper_controller.incorrectQs();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Text(
                                "False",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }
}

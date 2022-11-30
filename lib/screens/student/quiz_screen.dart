import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/student_exam_paper_controller.dart';
import 'package:exam_app/widgets/paper_completed.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ExamPaperController ctrl = Get.find();
  final paper_controller = Get.put(ExamPaperController());

  int index = 0;
  int points = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void nextQuestion() {
    if (index < ctrl.ExamList.mcqs.length - 1) {
      index++;
    } else {
      paper_controller.mcqstimeOver();
      ctrl.studentAutoCOmpleteSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ctrl.mcqs_paperTimeOver
        ? PaperCompleted()
        : ctrl.ExamList.mcqs.isEmpty
            ? Container()
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: nextQuestion, child: Text("Skip")),
                      ],
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   child: Container(
                    //       width: double.infinity,
                    //       height: 40,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Color(0xFF3F4768), width: 3),
                    //         borderRadius: BorderRadius.circular(50),
                    //       ),
                    //       child: Stack(
                    //         children: [
                    //           // LayoutBuilder provide us the available space for the conatiner
                    //           // constraints.maxWidth needed for our animation
                    //           LayoutBuilder(
                    //             builder: (context, constraints) => Container(
                    //               // from 0 to 1 it takes 60s
                    //               width: constraints.maxWidth * animation.value,
                    //               decoration: BoxDecoration(
                    //                 gradient: kPrimaryGradient,
                    //                 borderRadius: BorderRadius.circular(50),
                    //               ),
                    //             ),
                    //           ),
                    //           Positioned.fill(
                    //             child: Padding(
                    //               padding: EdgeInsets.symmetric(
                    //                   horizontal: kDefaultPadding / 2),
                    //               child: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                       "${(animation.value * 60).round()} minutes"),
                    //                   SvgPicture.asset("assets/icons/clock.svg"),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       )),
                    // ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Text.rich(
                        TextSpan(
                          text: "Question ${index + 1}",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kSecondaryColor),
                          children: [
                            TextSpan(
                              text:
                                  "/${ctrl.ExamList.mcqs.length.toString()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: kSecondaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1.0),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding: EdgeInsets.all(kDefaultPadding),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ctrl.ExamList.mcqs[index].statement + " ?",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: kBlackColor),
                            ),
                            SizedBox(height: kDefaultPadding),
                            InkWell(
                                onTap: () {
                                  if (ctrl.ExamList.mcqs[index].a ==
                                      ctrl.ExamList.mcqs[index].answer) {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_correctQs();
                                    });
                                  } else {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_incorrectQs();
                                    });
                                  }
                                },
                                child: _cardMCQ(
                                    '1. ${ctrl.ExamList.mcqs[index].a}')),
                            InkWell(
                                onTap: () {
                                  if (ctrl.ExamList.mcqs[index].b ==
                                      ctrl.ExamList.mcqs[index].answer) {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_correctQs();
                                    });
                                  } else {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_incorrectQs();
                                    });
                                  }
                                },
                                child: _cardMCQ(
                                    '2. ${ctrl.ExamList.mcqs[index].b}')),
                            InkWell(
                                onTap: () {
                                  if (ctrl.ExamList.mcqs[index].c ==
                                      ctrl.ExamList.mcqs[index].answer) {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_correctQs();
                                    });
                                  } else {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_incorrectQs();
                                    });
                                  }
                                },
                                child: _cardMCQ(
                                    '3. ${ctrl.ExamList.mcqs[index].c}')),
                            InkWell(
                                onTap: () {
                                  if (ctrl.ExamList.mcqs[index].d ==
                                      ctrl.ExamList.mcqs[index].answer) {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_correctQs();
                                    });
                                  } else {
                                    setState(() {
                                      nextQuestion();
                                      paper_controller.mcqs_incorrect();
                                    });
                                  }
                                },
                                child: _cardMCQ(
                                    '4. ${ctrl.ExamList.mcqs[index].d}'))
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              );
  }

  Card _cardMCQ(String text) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.black.withOpacity(0.13))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.justify,
              style:
                  TextStyle(fontSize: 18, color: Colors.grey.withOpacity(0.8)),
            ),
          ],
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

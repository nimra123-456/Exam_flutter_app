import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/controllers/student_exam_paper_controller.dart';
import 'package:exam_app/screens/student/quiz_screen.dart';
import 'package:exam_app/screens/student/theory_screen.dart';
import 'package:exam_app/screens/student/true_false.dart';

class ExamTabs extends StatefulWidget {
  const ExamTabs({Key? key}) : super(key: key);

  @override
  _ExamTabsState createState() => _ExamTabsState();
}

class _ExamTabsState extends State<ExamTabs>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool _isInForeground = true;
  final ExamPaperController ctrl = Get.find();
  final screenSwitchController = Get.put(ExamPaperController());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    if (!_isInForeground) {
    } else {
      if (ctrl.switchScreen >= 2) {
        ctrl.savePaper();
        Navigator.of(context).pop(true);
      } else {
        screenSwitchController.switchExamScreen();
        _onforgroundApp();
        print("foreground");
      }
    }
  }

  late AnimationController controller;

  late Animation animation;

  double beginAnim = 0.0;

  double endAnim = 1.0;

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
    controller = AnimationController(
        duration: Duration(minutes: int.parse(ctrl.ExamList.time)),
        vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller)
      ..addListener(() {
        setState(() {
          // Change here any Animation object value.
        });
      });

    startProgress();

    animation.addStatusListener((AnimationStatus animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        startProgress();
        ctrl.savePaper();
      }
    });
  }

  startProgress() {
    controller.forward();
  }

  stopProgress() {
    controller.stop();
  }

  resetProgress() {
    controller.reset();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _timer.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  late Timer _timer;
  int start = 0;
  startTimer() {
    const min = const Duration(minutes: 1);
    _timer = Timer.periodic(
      min,
      (Timer timer) {
        print(start);
        if (start < int.parse(ctrl.ExamList.time)) {
          start++;
          if (int.parse(ctrl.ExamList.time) - start == 5) {
            ExamRepo.showSnack(context, "5 minutes remaining for your Exam");
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Container(
              child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 40,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFF3F4768), width: 3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            // LayoutBuilder provide us the available space for the conatiner
                            // constraints.maxWidth needed for our animation
                            LayoutBuilder(
                              builder: (context, constraints) => Container(
                                // from 0 to 1 it takes 60s
                                width: constraints.maxWidth * animation.value,
                                decoration: BoxDecoration(
                                  gradient: kPrimaryGradient,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding / 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${ctrl.ExamList.time} minutes"),
                                    SvgPicture.asset("assets/icons/clock.svg"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ButtonTheme(
                        child: ElevatedButton(
                          style:ElevatedButton.styleFrom( backgroundColor: kColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),),
                          onPressed: () async {
                            ctrl.savePaper();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              "Upload Full Paper",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          gradient: kPrimaryGradient2,
                          borderRadius: BorderRadius.circular(20)),
                      indicatorWeight: 4.0,
                      // labelStyle: Constants.normalwhitestyle(),
                      tabs: [
                        Tab(text: 'MCQ\'s'),
                        Tab(text: 'True False'),
                        Tab(text: 'Theory'),
                      ]),
                ),
                Expanded(
                  child: TabBarView(
                    children: [QuizScreen(), TrueFalseScreen(), TheoryScreen()],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning_amber_outlined, color: Colors.yellow),
                Text('Warning!'),
              ],
            ),
            content:
                Text('You have maximum 2 chances to minimize or switch screen'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  if (ctrl.switchScreen >= 2) {
                    ctrl.savePaper();
                    Navigator.of(context).pop(true);
                  } else {
                    screenSwitchController.switchExamScreen();
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  _onforgroundApp() {
    return (showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_outlined, color: Colors.yellow),
            Text('Warning!'),
          ],
        ),
        content:
            Text('You have maximum 2 chances to minimize or switch screen'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    ));
  }
}

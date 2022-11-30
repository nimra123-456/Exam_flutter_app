import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';

import 'package:exam_app/models/user.dart';
import 'package:exam_app/screens/student/select_evalute.dart';
import 'package:exam_app/screens/teacher/paper_type.dart';
import 'package:exam_app/screens/teacher/teacher_result_part1.dart';
import 'package:exam_app/widgets/teacher_drawer.dart';
import 'package:exam_app/widgets/teacher_selection_card.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: TeacherDrawer(),
      ),
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Image.asset("assets/images/home.jpg")),
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(
                    "Hello ${User.MY_USER.name},",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    "Select What You want to perform",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => Get.to(() => PaperType()),
                          child: TeacherSelectionCard(
                              image: "matric", title: "Generate Q.Paper")),
                      InkWell(
                          onTap: () =>
                              Get.to(() => SelectEveluation(evaluate: false)),
                          child: TeacherSelectionCard(
                              image: "paper", title: "Conduct Paper")),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () =>
                              Get.to(() => SelectEveluation(evaluate: true)),
                          child: TeacherSelectionCard(
                              image: "result", title: "Evaluate Answers")),
                      InkWell(
                          onTap: () => Get.to(() => ResultPart1()),
                          child: TeacherSelectionCard(
                              image: "student", title: "Result")),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

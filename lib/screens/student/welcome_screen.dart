import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/session_controller.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/screens/student/assessment_records.dart';
import 'package:exam_app/screens/student/notifications.dart';
import 'package:exam_app/screens/student/result_screen.dart';
import 'package:exam_app/screens/student/select_semester_subject.dart';
import 'package:exam_app/screens/student/subjects_enrolled.dart';
import 'package:exam_app/widgets/app_drawer.dart';
import 'package:exam_app/widgets/test_type.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final SessionController _sessionController = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: AppDrawer(),
      ),
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
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        print("tapped");
                        Get.to(() => Notifications());
                      },
                      icon: Stack(
                        children: [
                          Icon(Icons.notifications),
                          Positioned(
                            top: 2,
                            right: 3,
                            child: Container(
                              height: 8,
                              width: 8,
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                          onTap: () => Get.to(SelectSemesterSubject()),
                          child: TestTypeCard(
                              gradient: kPrimaryGradient, title: "Exams")),
                      InkWell(
                          onTap: () => openSessionAlert("result"),
                          child: TestTypeCard(
                              gradient: kPrimaryGradient1, title: "Result")),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => openSessionAlert("subjects"),
                          child: TestTypeCard(
                              gradient: kPrimaryGradient2,
                              title: "Enrolled Courses")),
                      InkWell(
                          onTap: () => openSessionAlert("assessment"),
                          child: TestTypeCard(
                              gradient: kPrimaryGradient3,
                              title: "Assessment")),
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

  openSessionAlert(String navigateTo) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.only(top: 5.0),
            content: Container(
                height: 200.00,
                width: 300.00,
                margin: const EdgeInsets.only(
                    bottom: 0, left: 25, right: 25, top: 25),
                child: Obx(() {
                  if (_sessionController.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: _sessionController.sessionsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            String seession_id = _sessionController
                                .sessionsList[index].id
                                .toString();
                            Navigator.of(context).pop();
                            navigateTo == "result"
                                ? Get.to(ResultScreen(), arguments: seession_id)
                                : navigateTo == "subjects"
                                    ? Get.to(Subjects(), arguments: seession_id)
                                    : Get.to(() => AssessmentRecord(), arguments: seession_id);
                          },
                          child: ListTile(
                            title: Text(
                                _sessionController.sessionsList[index].name),
                          ));
                    },
                  );
                })),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                    child: Text(
                      'Cancel',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }
}

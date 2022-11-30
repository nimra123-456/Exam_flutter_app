import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/screens/student/start_exam_screen.dart';

class CourseList extends StatelessWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Subjects"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Get.to(() => StartExam()),
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: kGrayColor.withOpacity(0.13),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/forgot.png"))),
                                  ),
                                  Positioned(
                                    right: -30,
                                    bottom: -50,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(150),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: -20,
                                    top: -50,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(150),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Operating System",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.justify,
                                      style: Styles.headlineBold5(),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      DateFormat('yyyy-MM-dd | HH:mm')
                                          .format(DateTime.now()),
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          ),
        ));
  }
}

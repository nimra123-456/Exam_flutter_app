import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/controllers/session_controller.dart';
import 'package:exam_app/models/subjects_model.dart';
import 'package:exam_app/repository/repository_class.dart';
import 'package:exam_app/screens/teacher/mcq_screen.dart';
import 'package:exam_app/screens/teacher/theory_screen.dart';
import 'package:exam_app/screens/teacher/true_false_screen.dart';

class PaperType extends StatefulWidget {
  const PaperType({Key? key}) : super(key: key);

  @override
  _PaperTypeState createState() => _PaperTypeState();
}

class _PaperTypeState extends State<PaperType> {
  final _key = GlobalKey<FormState>();
  bool _isloading = false;
  String subject = "Subject",
      paper_type = "MCQ",
      session = "Class",
      marks = "",
      time = "",
      subj = "",
      session_id = "",
      subjectId = "";
  final SessionController _sessionController = Get.put(SessionController());
  List<Subjects> _subjectController = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paper Type"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPadding,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      openSessionAlert();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(
                          0x11304ffe,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(session),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (session_id == '') {
                        ExamRepo.showSnack(context, "Select Semester First");
                      } else {
                        openSubjectAlert();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(
                          0x11304ffe,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(subject),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    initialValue: marks,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Marks";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Color(
                          0x11304ffe,
                        ),
                        filled: true,
                        hintText: "Marks for Each Question",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (val) {
                      setState(() {
                        marks = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    initialValue: time,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Time";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                        fillColor: Color(
                          0x11304ffe,
                        ),
                        filled: true,
                        hintText: "Time for Each Question",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onChanged: (val) {
                      setState(() {
                        time = val;
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(
                      0x11304ffe,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration.collapsed(hintText: ''),
                          value: paper_type,
                          hint: Text("Paper"),
                          icon: Icon(
                            Icons.arrow_drop_down,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              paper_type = newValue!;
                            });
                          },
                          items: <String>['MCQ', 'True-False', 'Theory']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'paper type  is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(backgroundColor: kGreenColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),),
                    onPressed: () {
                      if (session_id == '' || subjectId == '') {
                        ExamRepo.showSnack(
                            context, "Select semester and Subject First");
                      } else {
                        if (_key.currentState!.validate()) {
                          paper_type == "MCQ"
                              ? Get.to(() => MCQScreen(), arguments: [
                                  {"first": session_id},
                                  {"second": subjectId},
                                  {"third": marks},
                                  {"fourth": time},
                                  {"fifth": paper_type}
                                ])
                              : paper_type == "Theory"
                                  ? Get.to(() => TheoryScreen(), arguments: [
                                      {"first": session_id},
                                      {"second": subjectId},
                                      {"third": marks},
                                      {"fourth": time},
                                      {"fifth": paper_type}
                                    ])
                                  : Get.to(() => TrueFalseScreen(), arguments: [
                                      {"first": session_id},
                                      {"second": subjectId},
                                      {"third": marks},
                                      {"fourth": time},
                                      {"fifth": paper_type}
                                    ]);

                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                _isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  openSessionAlert() {
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
                            setState(() {
                              session =
                                  _sessionController.sessionsList[index].name;
                              session_id = _sessionController
                                  .sessionsList[index].id
                                  .toString();
                            });
                            Navigator.of(context).pop();
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

  openSubjectAlert() {
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
                child: FutureBuilder<Subjects>(
                  future: Repository.getSubjects(session_id),
                  builder: (BuildContext context, snapshot) {
                    // AsyncSnapshot<Your object type>
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Please wait its loading...'));
                    } else {
                      if (snapshot.hasError)
                        return Center(child: Text('Error: ${snapshot.error}'));
                      else
                        return ListView.builder(
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      subject = snapshot.data!.data[index].name;
                                      subjectId = snapshot.data!.data[index].id
                                          .toString();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data!.data[index].name),
                                  ));
                            }); // snapshot.data  :- get your object which is pass from your downloadData() function
                    }
                  },
                )),
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

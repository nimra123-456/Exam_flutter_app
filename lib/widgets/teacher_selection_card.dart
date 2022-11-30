import 'package:flutter/material.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';

class TeacherSelectionCard extends StatelessWidget {
  String title;
  String image;

  TeacherSelectionCard({Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 100,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage("assets/teachers/$image.png"))),
        ),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Text(title, textAlign: TextAlign.center, style: Styles.headlineBold5()),
      ],
    );
  }
}

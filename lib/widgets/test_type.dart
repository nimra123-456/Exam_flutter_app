import 'package:flutter/material.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';

class TestTypeCard extends StatelessWidget {
  String title;
  Gradient gradient;

  TestTypeCard({Key? key, required this.gradient, required this.title})
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
            gradient: gradient,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
              child: Icon(
            Icons.cast_for_education_sharp,
            color: Colors.white,
            size: 50,
          )),
        ),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Text(title, textAlign: TextAlign.center, style: Styles.headlineBold5()),
      ],
    );
  }
}

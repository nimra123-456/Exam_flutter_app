import 'package:flutter/material.dart';
import 'package:exam_app/constants/style.dart';

class PaperCompleted extends StatelessWidget {
  const PaperCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
              "Your Paper is Submitted Solve Next Part of Your Exam! \nCLick 'Upload Full Button' When All Done Untill You get response message",
              textAlign: TextAlign.center,
              style: Styles.headlineBold5()),
        ),
      ),
    );
  }
}

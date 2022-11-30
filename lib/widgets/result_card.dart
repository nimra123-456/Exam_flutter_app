import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';

class ResultCard extends StatelessWidget {
  String title;
  var gp;

  ResultCard({Key? key, required this.title, required this.gp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: kGrayColor.withOpacity(0.13),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Styles.headlineBold5(),
              ),
              SizedBox(height: 10),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 10.0,
                    animation: true,
                    percent: 3.5 / 4,
                    center: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$gp", style: Styles.headlineBold5()),
                        Text("$title", style: Styles.headlineBold5()),
                      ],
                    ),
                    backgroundColor: kGrayColor.withOpacity(0.4),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: kColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

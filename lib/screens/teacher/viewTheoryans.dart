import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/style.dart';

class ViewTheoryAns extends StatelessWidget {
  const ViewTheoryAns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(argumentData,
          style: Styles.headline6(),),
        ),
      ),
    );
  }
}

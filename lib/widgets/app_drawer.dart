import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/screens/login_option.dart';
import 'package:exam_app/screens/student/account_page.dart';
import 'package:exam_app/screens/student/assessment_records.dart';
import 'package:exam_app/screens/student/edit_profile.dart';
import 'package:exam_app/screens/student/notifications.dart';
import 'package:exam_app/screens/student/result_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              User.MY_USER.name,
              style: Styles.bodyTextBold1(),
            ),
            accountEmail: Text(
              User.MY_USER.email,
              style: Styles.bodyText2(),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  User.MY_USER.name[0],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
          ),
          ListTile(
            onTap: () => Navigator.pop(context),
            title: Text("Home", style: Styles.bodyText1()),
          ),
          ListTile(
              onTap: () => Get.to(() => ResultScreen()),
              title: Text("Result", style: Styles.bodyText1())),
          ListTile(
              onTap: () => Get.to(() => EditProfile()),
              title: Text("Edit Profile", style: Styles.bodyText1())),
          ListTile(
            onTap: () => Get.to(() => Notifications()),
            title: Text("Notifications", style: Styles.bodyText1()),
          ),
          ListTile(
              onTap: () => Get.to(() => AccountPage()),
              title: Text("Account Page", style: Styles.bodyText1())),
          ListTile(
              onTap: () => Get.to(() => AssessmentRecord()),
              title: Text("Assessment Tests", style: Styles.bodyText1())),
          Spacer(),
          Divider(),
          ListTile(
              onTap: () async {
                await ExamRepo.clearPref();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (contetx) => LoginOptionScreen()));
              },
              trailing: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text("Log Out", style: Styles.bodyText1())),
          SizedBox(
            height: kDefaultPadding,
          )
        ],
      ),
    );
  }
}

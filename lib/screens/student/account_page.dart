import 'package:flutter/material.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/widgets/profile_avatar.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileAvatarWidget(),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                "About",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                User.MY_USER.no == null ? "" : User.MY_USER.no.toString(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
              child: Text(
                User.MY_USER.email == null ? "" : User.MY_USER.email.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                User.MY_USER.address ?? "",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

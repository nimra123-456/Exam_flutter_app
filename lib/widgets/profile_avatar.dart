import 'package:flutter/material.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/constants/style.dart';
import 'package:exam_app/models/user.dart';

class ProfileAvatarWidget extends StatelessWidget {
  ProfileAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            gradient: kPrimaryGradient2,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 160,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(300)),
                      child: User.MY_USER.image != null
                          ? Image.network(
                              ImageUrl + User.MY_USER.image,
                              fit: BoxFit.cover,
                              height: 135,
                              width: 135,
                            )
                          : Image.asset(
                              'assets/images/avatar.png',
                              fit: BoxFit.cover,
                              height: 135,
                              width: 135,
                            ),
                    ),
                  ],
                ),
              ),
              Text(
                User.MY_USER.name,
                style: Styles.headline3(),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                User.MY_USER.email,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back))
      ],
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:exam_app/constants/constants.dart';
import 'package:exam_app/controllers/repository.dart';
import 'package:exam_app/models/user.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String uname = User.MY_USER.name,
      phone = User.MY_USER.no ?? '',
      nic = User.MY_USER.cnic ?? '',
      email = User.MY_USER.email ?? '',
      address = User.MY_USER.address ?? '';
  late String url;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File _image = File("");
  bool update = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: InkWell(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: _image.path.isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        "assets/images/avatar.png",
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        _image,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        initialValue: uname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Name";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            filled: true,
                            hintText: "Full Name",
                            fillColor: Color(
                              0x11304ffe,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            uname = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        initialValue: phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Phone No";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Color(
                              0x11304ffe,
                            ),
                            filled: true,
                            hintText: "Phone No",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onChanged: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        initialValue: nic,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your NIC No";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Color(
                              0x11304ffe,
                            ),
                            filled: true,
                            hintText: "NIC No",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onChanged: (val) {
                          setState(() {
                            nic = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        initialValue: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Email";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Color(
                              0x11304ffe,
                            ),
                            filled: true,
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: TextFormField(
                        initialValue: address,
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Address";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Color(
                              0x11304ffe,
                            ),
                            filled: true,
                            hintText: "Address",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onChanged: (val) {
                          setState(() {
                            address = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),),
                          onPressed: () async {
                            setState(() {
                              update = false;
                            });
                            await updateProfile();
                            setState(() {
                              update = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  updateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fileName = _image != null ? _image.path.split("/").last : '';

    var url = API_BASE_URL + "user/update";
    var formData = FormData.fromMap({
      "name": uname,
      "email": email,
      "no": phone,
      "cnic": nic,
      "id": User.MY_USER.id.toString(),
      "role": User.MY_USER.role,
      'image': _image != null
          ? [
              await MultipartFile.fromFile(_image.path, filename: fileName),
            ]
          : ""
    });
    var response = await Dio().post(url, data: formData);
    if (response.statusCode == 200) {
      print(response.data["data"]["image"].toString());
      prefs.setString("image", response.data["data"]["image"].toString() ?? '');

      ExamRepo.showSnack(context, response.data["message"]);
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(image!.path);
    });
  }
}

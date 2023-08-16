import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/screens/auth/login_screen.dart';
import 'package:gift_app/widgets/alert_dialog.dart';
import 'package:gift_app/widgets/loader.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  XFile? xfile;
  String image = "";
  String? imageUrl;
  String uid = "";
  @override
  void initState() {
    email.text = LocalStorage.instance.getString(LocalStorage.email) ?? "";
    firstName.text =
        LocalStorage.instance.getString(LocalStorage.firstName) ?? "";
    lastName.text =
        LocalStorage.instance.getString(LocalStorage.lastName) ?? "";
    mobile.text = LocalStorage.instance.getString(LocalStorage.mobile) ?? "";
    imageUrl = LocalStorage.instance.getString(LocalStorage.image) ?? "";
    uid = LocalStorage.instance.getString(LocalStorage.uid) ?? "";
    super.initState();
  }

  void userData() async {
    showIndiCator(context);
    if (image.isNotEmpty) {
      String ext = image.split(".").last;
      String imgpath =
          // ignore: prefer_interpolation_to_compose_strings
          DateTime.now().millisecondsSinceEpoch.toString() + "." + ext;
      if (!Uri.parse(imgpath).isAbsolute) {
        Reference reference = FirebaseStorage.instance.ref(imgpath);
        await reference.putFile(File(image));
        imageUrl = await reference.getDownloadURL();
      }
    }
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection("users").doc(uid).update({
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
      "mobile": mobile.text,
      "image": imageUrl,
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: const Color(0xFF9c6d9d),
          actions: [
            InkWell(
                onTap: () {
                  alertDialogView(
                      context: context,
                      title: "Logout",
                      contet: "Are you sure to logout?",
                      yesPress: () async {
                        await LocalStorage.instance.clear();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LogInScreen()),
                            (route) => false);
                      },
                      noPress: () {
                        Navigator.of(context).pop();
                      });
                },
                child: const Icon(Icons.logout)),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                xfile =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                image = xfile!.path;
                setState(() {});
              },
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF9c6d9d),
                      radius: 55,
                      backgroundImage: image == ""
                          ? Image.network(imageUrl!).image
                          : Image.file(File(image)).image,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 4,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: -1,
                                  color: Color(0xFF9c6d9d),
                                  offset: Offset(1, 1)),
                              BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: -1,
                                  color: Color(0xFF9c6d9d),
                                  offset: Offset(-1, -1)),
                            ],
                            color: const Color(0xFF9c6d9d),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: firstName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "reqiured..!";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'First name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: lastName,
              validator: (value) {
                if (value!.isEmpty) {
                  return "reqiured..!";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'last name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: mobile,
              validator: (value) {
                if (value!.isEmpty) {
                  return "reqiured..!";
                } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                    .hasMatch(value)) {
                  return "enter valid mobile number..!";
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Mobile No',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: email,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email is reqired...";
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return "Enter Proper Format..";
                } else {
                  return null;
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                if (globalKey.currentState!.validate()) {
                  userData();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF9c6d9d),
                ),
                height: 50,
                child: const Center(
                  child: Text("Save",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

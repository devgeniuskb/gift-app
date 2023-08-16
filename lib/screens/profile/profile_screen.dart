import 'dart:io';

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF9c6d9d),
      ),
      body: ListView(
        padding: const  EdgeInsets.symmetric(horizontal: 16),
        children: [
          
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () async {
              ImagePicker imagePicker = ImagePicker();
              xfile = await imagePicker.pickImage(source: ImageSource.gallery);
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
                        ? Image.asset("assets/icon/profile.png").image
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
              if (globalKey.currentState!.validate()) {}
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
    );
  }
}

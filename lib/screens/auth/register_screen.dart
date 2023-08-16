import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gift_app/screens/auth/login_screen.dart';
import 'package:gift_app/screens/bottombar.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  XFile? xfile;
  String image = "";
  bool isPasswordHide = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/image/bg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                  child: Text(
                "Crinsezza",
                style: TextStyle(
                  color: Color.fromARGB(255, 44, 22, 14),
                  fontSize: 40,
                ),
              )),
              const SizedBox(
                height: 5,
              ),
              const Center(
                child: Text(
                  "Gift",
                  style: TextStyle(color: Color(0xFF9c6d9d), fontSize: 30),
                ),
              ),
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
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is reqired...";
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(value)) {
                    return "Enter Proper Format..";
                  } else {
                    return null;
                  }
                },
                obscureText: isPasswordHide,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        isPasswordHide = !isPasswordHide;
                        setState(() {});
                      },
                      child: isPasswordHide
                          ? Image.asset(
                              "assets/icon/hide.png",
                              scale: 20,
                            )
                          : Image.asset(
                              "assets/icon/visible.png",
                              scale: 20,
                            ),
                    ),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (globalKey.currentState!.validate()) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const BottomBar()),
                        (route) => false);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF9c6d9d),
                  ),
                  height: 50,
                  child: const Center(
                    child: Text("Sign up",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ?',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogInScreen()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFF9c6d9d),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

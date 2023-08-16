import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:gift_app/config/local_storage.dart';
import 'package:gift_app/screens/admin/admin_bottombar.dart';
import 'package:gift_app/screens/auth/register_screen.dart';
import 'package:gift_app/widgets/loader.dart';
import 'package:gift_app/widgets/toast.dart';

import '../bottombar.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isPasswordHide = true;
  void userData() async {
    showIndiCator(context);
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.text, password: password.text);
      if (userCredential.user!.uid == "LKOJ3KJrQyMQQ7Ej7STCS0ruTIE2") {
        await LocalStorage.instance.setBool(LocalStorage.isAdmin, true);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AdminBottomBar()),
            (route) => false);
      } else if (userCredential.user != null) {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        DocumentSnapshot data = await firebaseFirestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        await LocalStorage.instance.setBool(LocalStorage.isLogin, true);
        await LocalStorage.instance.setString(LocalStorage.email, email.text);
        await LocalStorage.instance
            .setString(LocalStorage.uid, userCredential.user!.uid);
        await LocalStorage.instance
            .setString(LocalStorage.image, data['image']);
        await LocalStorage.instance
            .setString(LocalStorage.mobile, data['mobile']);
        await LocalStorage.instance
            .setString(LocalStorage.lastName, data['lastName']);
        await LocalStorage.instance
            .setString(LocalStorage.firstName, data['firstName']);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const BottomBar()),
          (route) => false,
        );
      }
    } catch (e) {
      showToast(message: "wrong password...");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/image/bg.jpg",
              ),
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
                height: 140,
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
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
                    child: Text("Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            color: Color(0xFF9c6d9d),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_app/screens/auth/register_screen.dart';

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
                child:  Text(
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

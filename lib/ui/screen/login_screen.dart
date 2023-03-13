import 'dart:html';

import 'package:flutter/material.dart';
import 'package:medcare_desk/ui/screen/home_screen.dart';

import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool checkIsEmail(String value) {
    RegExp emailRegEx = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (emailRegEx.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/image/desk.png",
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Color.fromARGB(255, 0, 5, 10),
                        ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            checkIsEmail(value)) {
                          return null;
                        } else {
                          return 'Enter valid email';
                        }
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'E-mail',
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return "enter password";
                        }
                      },
                      obscureText: isObscure,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          labelText: 'password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                            child: Icon(
                              isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    label: "Login",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }
                    },
                    buttonColor: Colors.blue,
                    elevation: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/main.dart';
import 'package:sharedpref_login/screens/home/todo_home1.dart';

class LoginScreen extends StatelessWidget {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  // email validation
  String emailValidation(String emailValue) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp emailRegExp = RegExp(emailPattern);

    if (!emailRegExp.hasMatch(emailValue)) {
      return "Enter a valid email id";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    // print(mediaQuery.height);
    return Scaffold(
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                    hintText: "Enter Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Email id is mandatory";
                    } else if (value.isNotEmpty) {
                      String regExp = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
                      String emailText = userController.text;

                      RegExp regx = RegExp(regExp);

                      if (!regx.hasMatch(emailText)) {
                        return "email id invalid";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Password is mandatory";
                    } else if (value.isNotEmpty) {
                      String regex =
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$';
                      RegExp passExp = RegExp(regex);

                      String password = passwordController.text;

                      if (!passExp.hasMatch(password)) {
                        return "invalid password";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12.0),
                // TextFormField(
                //   controller: confirmPasswordController,
                //   decoration: const InputDecoration(
                //     hintText: "Confirm Password",
                //     border: OutlineInputBorder(),
                //   ),
                //   validator: (String? value) {
                //     if (value == userController.text) {
                //       return "Passwords are do not match";
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // shared preference set instance
                        final _sharedPref =
                            await SharedPreferences.getInstance();
                        _sharedPref.setBool(sharedPreferenceKey, true);

                        // goto home screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TodoHomee(),
                          ),
                        );
                      } else {
                        print("fields are empty");
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

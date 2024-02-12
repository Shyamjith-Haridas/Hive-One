import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/main.dart';

import '../home/todo_home1.dart';
import '../login/login.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  void gotoLogin() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
    );
  }

  // shared preferences function
  Future<void> checkUserCredential() async {
    final sharedUser = await SharedPreferences.getInstance();
    final _user = sharedUser.getBool(sharedPreferenceKey);

    if (_user == null || _user == false) {
      gotoLogin();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => TodoHomee(),
        ),
      );
    }
  }

  @override
  void initState() {
    checkUserCredential();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/insta.jpg"),
      ),
    );
  }
}

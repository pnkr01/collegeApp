import 'dart:async';
import 'package:college_app/views/auth/utils/login_sign.dart';
import 'package:college_app/views/home/home.dart';
import 'package:flutter/material.dart';
import '../../global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer() {
    Timer(const Duration(seconds: 2), () {
      if (firebaseAuth.currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LogInCumSignUpScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.50,
          ),
          const Center(
            child: Text(
              "Welcome To Student Connect App",
              softWrap: true,
              style: TextStyle(fontSize: 30.0, fontFamily: "Signatra"),
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}

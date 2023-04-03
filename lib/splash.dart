import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supplierportal/styles/common%20Color.dart';
import 'package:supplierportal/widgets/shimmer.dart';
import 'dart:async';
import 'model/Dashboard.dart';
import 'model/Login/entity.dart';
import 'model/Login/login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? ip;
  @override
  void initState() {
    super.initState();
    splashFunction();
  }

  Future<void> splashFunction() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ip = prefs.getString('ip');
    });
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ip == null ? const EntityPage() : const SessionCheck())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Hero(
          tag: 'login',
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              child: Image.asset('assets/images/loginPage.jpg')),
        ));
  }
}

class SessionCheck extends StatefulWidget {
  const SessionCheck({Key? key}) : super(key: key);

  @override
  State<SessionCheck> createState() => _SessionCheckState();
}

class _SessionCheckState extends State<SessionCheck> {
  int? sessionId;

  @override
  void initState() {
    super.initState();
    splashFunction();
  }

  Future<void> splashFunction() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sessionId = prefs.getInt('SessionId');
    });
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    sessionId == null ? const Login() : const Dashboard())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            "assets/images/supplier.gif",
          ),
        ),
      ),
    );
  }
}

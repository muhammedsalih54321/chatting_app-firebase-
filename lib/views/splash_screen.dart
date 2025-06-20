import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 FirebaseAuth auth=FirebaseAuth.instance;

  login(){
  if (auth.currentUser!=null) {
     Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, "/home")
    );
  }else{
     Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, "/welcome")
    );
  }
 }
  @override
  void initState() {
    login();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF24786D),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Image(image: AssetImage("assets/images/Logo.png")),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/pages/login.dart';

import '../utils/images.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<User?>? _listner; //listen is of  StreamSubscription type ,so we assigned the listen to a variable
  @override                           // the listener is opened to check the authstatechanges in the splash
                                      // after the splash the listener should be closed to avoid any errors in the context
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    _listner = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Login()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage()));
      }
    });
  }

  @override
  void dispose() { //close the listner
    _listner?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ImagePath.background), fit: BoxFit.cover)),
          child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Padding(padding: const EdgeInsets.all(80),child: Image.asset(ImagePath.baseHeader),
            ),
            const CircularProgressIndicator(),
          ],),),
    ));
  }
}

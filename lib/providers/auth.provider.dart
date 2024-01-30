import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/pages/register.dart';

import '../pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  GlobalKey<FormState>? formKey;
  bool obsecureText = false;

  void providerInit() {
    formKey = GlobalKey<FormState>();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  void providerDispose() {
    formKey = null;
    passwordController = null;
    nameController = null;
    emailController = null;
    obsecureText = false; //have the same initial value
  }

  void openRegisterPage(BuildContext context) {
    //in the login page to go to the register page
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Register()));
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const Login()));
  }

  Future<void> signUp(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        //check if the current state is valid
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!
                    .text); //! null assertion because we are certain it exists
        if (credentials.user!=null){
        await credentials.user?.updateDisplayName(nameController!.text);
      }
      }
    } catch (e) {}
  }


  Future<void> login (BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        //check if the current state is valid
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController!.text,
            password: passwordController!
                .text); //! null assertion because we are certain it exists
        if (credentials.user!=null){
          await credentials.user?.updateDisplayName(nameController!.text);
        }
      }
    } catch (e) {}
  }



}

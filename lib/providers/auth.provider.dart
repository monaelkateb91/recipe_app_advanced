import 'package:flutter/material.dart';
import 'package:recipe_app_advanced/pages/home_page.dart';
import 'package:recipe_app_advanced/pages/register.dart';
import 'package:overlay_kit/overlay_kit.dart';

import '../pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/toast_message_status.dart';
import '../widgets/toast_message.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? nameController;
  GlobalKey<FormState>? formKeyRegister;
  GlobalKey<FormState>? formKeyLogin;
  bool obsecureText = true;

  void providerInit() {
    formKeyRegister = GlobalKey<FormState>();
    formKeyLogin = GlobalKey<FormState>();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
  }

  void providerDispose() {
    formKeyRegister = null;
    formKeyLogin=null;
    passwordController = null;
    nameController = null;
    emailController = null;
    obsecureText = false;
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
      if (formKeyRegister?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        //check if the current state is valid
        var credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!
                    .text); //! null assertion because we are certain it exists
        if (credentials.user != null) {
          await credentials.user?.updateDisplayName(nameController!.text);
          OverlayLoadingProgress.stop();
          providerDispose();

          if (context.mounted){ //if it exists
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomePage()));
          }

        }
        OverlayLoadingProgress.stop();
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
    }
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    try {
      if (formKeyLogin?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        //check if the current state is valid
        var credentials = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!
                    .text); //! null assertion because we are certain it exists
        if (credentials.user != null) {

          OverlayLoadingProgress.stop();
          providerDispose();
          OverlayToastMessage.show(widget: const ToastMessageWidget(message: 'you loged in successuflly', toastMessageStatus: ToastMessageStatus.success,),);

if (context.mounted){ //if it exists
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => const HomePage()));
}
}

        OverlayLoadingProgress.stop();
      }
    }
    on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();

      if (e.code == 'user-not-found') {
        OverlayToastMessage.show(
          widget: const ToastMessageWidget(
            message: 'user not found',
            toastMessageStatus: ToastMessageStatus.failed,
          ),
        );
      } else if (e.code == 'wrong-password') {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'Wrong password provided for that user.',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      } else if (e.code == "user-disabled") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'This email Account was disabled',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      } else if (e.code == "invalid-credential") {
        OverlayToastMessage.show(
            widget: const ToastMessageWidget(
              message: 'invalid-credential',
              toastMessageStatus: ToastMessageStatus.failed,
            ));
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(textMessage: 'General Error $e');
    }
  }


  void signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
   await FirebaseAuth.instance.signOut() ;
   if (context.mounted )//if it exists
    {
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const Login()), (route) => false);
    }

   OverlayLoadingProgress.stop();

   //Navigator.pushReplacement(
        //context, MaterialPageRoute(builder: (_) => const SplashScreen())));
  }
}

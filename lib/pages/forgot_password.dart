import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }
Future passwordreset()async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('enter your email'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(controller: emailcontroller,),
          )
       ,MaterialButton(onPressed: (){passwordreset();},child: Text('reset password'),)
        ],
      ),
    );
  }
}

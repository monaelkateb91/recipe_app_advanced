
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../service/authenticatio.dart';
import '../service/image.serive.dart';

class UserProvider with ChangeNotifier {
  // final user =FirebaseAuth.instance.currentUser;
  // if(user!=null){
  //   final name =user.displ
  // }
  // // UserData? _userData;
  // //
  // // UserData? get userData => _userData;

 void updateUserName(){
   var user=FirebaseAuth.instance.currentUser;
   user?.updateDisplayName('mona');}

  void updateImage(){
    var user=FirebaseAuth.instance.currentUser;
    user?.updatePhotoURL('https://firebasestorage.googleapis.com/v0/b/recipe-app-advanced-39dc9.appspot.com/o/profile.png?alt=media&token=bfce1d80-e95d-49d8-a688-181d979dd734');}

// void displayName( ){ var user=await FirebaseAuth.instance.currentUser;
//
// user?.displayName('mona');}

}


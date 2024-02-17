import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  final currentuser=FirebaseAuth.instance.currentUser!;
  final name=FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        children: [
          StreamBuilder(stream: FirebaseFirestore.instance.collection('user').doc(currentuser.email).snapshots(),
              builder: (context,snapshots) {
if (snapshots.hasData){
  final userdata=snapshots.data!.data()as Map<String,dynamic>;

}else if (snapshots.hasError)
  {
    return Center(child: Text("error"+snapshots.error.toString()));
  }

              }
              ),
       ],
      ),

    ));
  }
}

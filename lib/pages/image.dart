//
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// class Image_user extends StatefulWidget {
//   const Image_user({super.key});
//
//   @override
//   State<Image_user> createState() => _Image_userState();
// }
//
// class _Image_userState extends State<Image_user> {
//   String imageUrl='';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Row(
//       children: [ IconButton(onPressed: ()async{
//         ImagePicker imagePicker=ImagePicker();
//        XFile ?file= await imagePicker.pickImage(source: ImageSource.gallery);
//        print('${file?.path}');
//        if(file!=null)return;
//        String uniqueFile=DateTime.now().millisecondsSinceEpoch.toString();
//
//        Reference referenceRoot=FirebaseStorage.instance.ref();
//        Reference referenceDirImage=referenceRoot.child('profile.png');
//         Reference referenceImageToUpload=referenceDirImage.child(uniqueFile);
//         await referenceImageToUpload.putFile(File(file!.path));
//        imageUrl=await referenceImageToUpload.getDownloadURL();
//
//
//     } icon: Icon(Icons.camera)),
//         ElevatedButton(onPressed:()async{
//
//
//           }, child: child)
//
//       ],
//     ),);
//   },
// }

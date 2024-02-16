
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String filePath) async {
    final ref = _storage.ref().child('user_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(File(filePath));
    return await ref.getDownloadURL();
  }
}
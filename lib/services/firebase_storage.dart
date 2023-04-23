import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageClass {
  final FirebaseStorage storage = FirebaseStorage.instance;
  // final currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<String> uploadFile(
      String filePath, String classID, String postID, String fileName) async {
    File file = File(filePath);

    TaskSnapshot snap = await storage
        .ref('class posts/$classID/$postID/$fileName')
        .putFile(file);

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

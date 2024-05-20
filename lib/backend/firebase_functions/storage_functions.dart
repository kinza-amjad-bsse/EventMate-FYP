import 'dart:io' as io;
import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Utils/print_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Utils/my_print.dart';

class FirebaseStorageFunctions {
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<String> uploadImage({
    required String path,
  }) async {
    try {
      String fileName = path.split("/").last;
      Reference reference = firebaseStorage
          .ref()
          .child("users")
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(fileName);
      UploadTask uploadTask = reference.putFile(
        io.File(path),
      );
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      myPrint(
        message: "${e.message}",
        type: PrintTypes.error,
      );
      return "";
    }
  }

  static Future<List<String>> uploadImages({
    required List<String> allPaths,
  }) async {
    List<String> urls = [];
    for (String eachPath in allPaths) {
      String url = await uploadImage(
        path: eachPath,
      );
      urls.add(url);
    }
    return urls;
  }
}

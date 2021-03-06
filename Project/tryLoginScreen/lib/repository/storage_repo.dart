import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../locator.dart';
import '../repository/auth_repo.dart';

class StorageRepo {
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://tryloginscreen.appspot.com");
  AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file, String email) async {
    var userId = email;
    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../locator.dart';
import '../model/user_model.dart';
import '../repository/auth_repo.dart';
import '../repository/storage_repo.dart';

class UserController {
  UserModel _currentUser;
  AuthRepo _authRepo = locator.get<AuthRepo>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();
  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

  Future<void> uploadProfilePicture(File image, String email) async {
    _currentUser.avatarUrl = await _storageRepo.uploadFile(image, email);
  }

  Future<String> getAvatarUrl(String email) async {
    return await _storageRepo.getUserProfileImage(email);
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.email);
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(
        email: email, password: password);

    try {
      _currentUser.avatarUrl = await getDownloadUrl();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithGoogle() async {
    _currentUser = await _authRepo.signInWithGoogle();

    try {
      _currentUser.avatarUrl = await getDownloadUrl();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithFacebook() async {
    _currentUser = await _authRepo.signInWithFacebook();
    try {
      _currentUser.avatarUrl = await getDownloadUrl();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {String email,
      String password,
      String username,
      String gender,
      String dob,
      String phone}) async {
    _currentUser = await _authRepo.signUpWithEmailAndPassword(
      email: email,
      password: password,
      username: username,
      gender: gender,
      dob: dob,
      phone: phone,
    );
  }

  void updateDisplayName(String displayName) {
    _currentUser.displayName = displayName;
    _authRepo.updateDisplayName(displayName);
  }

  Future<bool> validateCurrentPassword(String password) async {
    return await _authRepo.validatePassword(password);
  }

  void updateUserPassword(String password) {
    _authRepo.updatePassword(password);
  }

  Future<bool> initCheckPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('isUser')) {
      return true;
    }
    return false;
  }

  Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
  }
}

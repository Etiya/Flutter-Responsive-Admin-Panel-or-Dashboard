import 'dart:developer';
import 'dart:io';
import 'package:admin/models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ProfileState { initial, loading, loaded, error }

class ProfileController extends ChangeNotifier {
  ProfileController(this.firebaseDatabase);
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  FirebaseDatabase firebaseDatabase;

  ProfileState? _state = ProfileState.initial;
  ProfileState? get state => _state;
  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  File? image;
  String? imagePath;

  set state(ProfileState? value) {
    _state = value;
    notifyListeners();
  }

  // UserInfo? _userFromFirebase(auth.User? user) {
  //   if (user == null) {
  //     return null;
  //   }
  //   return UserInfo(user.uid, user.email);
  // }

  Future<void> updateDisplayName(String displayName) async {
    try {
      state = ProfileState.loading;
      await firebaseAuth.currentUser?.updateDisplayName(displayName);
      state = ProfileState.loaded;
    } catch (_) {
      state = ProfileState.error;
    }
  }

  Future<void> updateMail(String email) async {
    try {
      state = ProfileState.loading;
      await firebaseAuth.currentUser?.updateEmail(email);
      state = ProfileState.loaded;
    } catch (e) {
      log(e.toString());
      state = ProfileState.error;
    }
  }

  Future<void> updateProfilePhoto() async {
    try {
      state = ProfileState.loading;
      await firebaseAuth.currentUser?.updatePhotoURL(imagePath);
      state = ProfileState.loaded;
    } catch (_) {
      state = ProfileState.error;
    }
  }

  Future<File?> pickImage() async {
    try {
      state = ProfileState.loading;
      final ImagePicker _picker = ImagePicker();
      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        return image;
      }
      state = ProfileState.loaded;
    } catch (_) {
      state = ProfileState.error;
    }
    return null;
  }

  Future<void> uploadImage(File file) async {
    if (image != null) {
      try {
        state = ProfileState.loading;

        var uploadTask = await storage
            .ref('profile_pics')
            .child(firebaseAuth.currentUser!.uid)
            .putFile(file);
        imagePath = await uploadTask.ref.getDownloadURL();

        state = ProfileState.loaded;
      } catch (e) {
        state = ProfileState.error;
      }
    }
  }

  // Future<void> updatePhoneNumber(String displayName) async {
  //   auth.PhoneAuthCredential? phoneAuthCredential;
  //   try {
  //     state = ProfileState.loading;
  //     await firebaseAuth.currentUser?.updatePhoneNumber(phoneAuthCredential!);
  //     state = ProfileState.loaded;
  //   } catch (_) {
  //     state = ProfileState.error;
  //   }
  // }

  Future<void> addAppUserInfo(AppUser appUser) async {
    try {
      state = ProfileState.loading;
      await firebaseDatabase.ref('appUser').set(appUser.toMap());
      state = ProfileState.loaded;
    } catch (e) {
      state = ProfileState.error;
    }
  }

  Future<void> updateAddUserInfo(AppUser appUser) async {
    try {
      state = ProfileState.loading;
      var dataRef = firebaseDatabase.ref().child("appUser");
      var snapshot =
          await dataRef.orderByChild("name").equalTo(appUser.name).once();

      Map map = snapshot.snapshot.value as Map<dynamic, dynamic>;
      String key = map.keys.first;
      await dataRef.child(key).set(appUser.toMap());
      state = ProfileState.loaded;
    } catch (e) {
      state = ProfileState.error;
    }
  }

  Future<AppUser?> getAppUserInfo() async {
    try {
      state = ProfileState.loading;
      var snapShot = await firebaseDatabase.ref().child('appUser').once();

      final userData = snapShot.snapshot.value;
      if (userData != null && userData is Map<String, dynamic>) {
        _appUser = AppUser.fromMap(userData);
        log(_appUser.toString());
      } else {}
      state = ProfileState.loaded;
    } catch (e) {
      state = ProfileState.error;
    }
    return _appUser;
  }
}

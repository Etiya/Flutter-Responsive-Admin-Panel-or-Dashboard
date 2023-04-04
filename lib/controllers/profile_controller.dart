import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ProfileState { initial, loading, loaded, error }

class ProfileController extends ChangeNotifier {
  auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  ProfileState? _state = ProfileState.initial;
  ProfileState? get state => _state;

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
    } catch (_) {
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

  Future<void> pickImage() async {
    try {
      state = ProfileState.loading;
      final ImagePicker _picker = ImagePicker();
      var pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
      state = ProfileState.loaded;
    } catch (_) {
      state = ProfileState.error;
    }
  }

  Future<void> uploadImage() async {
    if (image != null) {
      try {
        state = ProfileState.loading;

        var uploadTask = await storage
            .ref('profile_pics')
            .child(firebaseAuth.currentUser!.uid)
            .putFile(image!);
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
}

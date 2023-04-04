import 'package:admin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

enum AuthenticationState { initial, loading, loaded, error }

class AuthenticationController extends ChangeNotifier {
  AuthenticationController(this.firebaseAuth) {}
  auth.FirebaseAuth firebaseAuth;

  UserInfo? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserInfo(user.uid, user.email);
  }

  Stream<UserInfo?>? get user {
    return firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  AuthenticationState? _state = AuthenticationState.initial;
  AuthenticationState? get state => _state;

  set state(AuthenticationState? value) {
    _state = value;
    notifyListeners();
  }

  Future<UserInfo?> createNewUser(String email, String password) async {
    auth.UserCredential? credential;
    try {
      state = AuthenticationState.loading;
      credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      state = AuthenticationState.loaded;
    } catch (_) {
      state = AuthenticationState.error;
    }
    return _userFromFirebase(credential?.user);
  }

  Future<UserInfo?> signIn(String email, String password) async {
    auth.UserCredential? credential;
    try {
      state = AuthenticationState.loading;
      credential = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password));
      state = AuthenticationState.loaded;
    } catch (_) {
      state = AuthenticationState.error;
    }
    return _userFromFirebase(credential?.user);
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}

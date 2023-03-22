// Unit Test Code
import 'package:admin/controllers/authentication_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admin/models/user_model.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  final auth = MockFirebaseAuth();
  group('AuthenticationController', () {
    AuthenticationController authenticationController;
    authenticationController = AuthenticationController(auth);

    test('initial state is initial', () {
      expect(authenticationController.state, AuthenticationState.initial);
    });

    test('createNewUser should return user info', () async {
      final userInfo = await authenticationController.createNewUser(
          'test@example.com', 'password');

      expect(userInfo, isA<UserInfo>());
      expect(userInfo?.uid, isNotNull);
      expect(userInfo?.email, equals('test@example.com'));

      expect(authenticationController.state, AuthenticationState.loaded);

      await authenticationController.signOut();

      expect(authenticationController.state, AuthenticationState.loaded);
    });

    test('AuthenticationController signIn', () async {
      await authenticationController.signIn('test@example.com', 'password');
      expect(authenticationController.state, AuthenticationState.loaded);
    });

      test('AuthenticationController', () {
    expect(authenticationController.user, isNotNull);
  });
  });
}

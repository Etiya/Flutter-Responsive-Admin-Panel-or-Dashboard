// Unit Test Code
import 'package:admin/controllers/dashboard_controller.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_database/firebase_database.dart';

import 'mocks/dashboard_elements_mock.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseDatabase? firebaseDatabase;
  DashBoardController? controller;
  MockFirebaseDatabase.instance
      .ref()
      .child('dashboardmodel')
      .set(mockDashboardElements);
  group('DashboardController', () {
    setUp(() {
      firebaseDatabase = MockFirebaseDatabase.instance;
      controller = DashBoardController(firebaseDatabase!);
    });
    test('Test getDashboardElements', () async {
      await controller!.getDashboardElements();
      expect(controller!.state, equals(DashboardStates.loaded));
    });

    test('Test addNewFeature', () async {
      await controller!.addNewFeature(fakeDashboardModel);
      expect(controller!.state, equals(DashboardStates.loaded));
    });

    test('Test updateFeature', () async {
      await controller!.updateFeature(fakeDashboardModel);
      expect(controller!.state, equals(DashboardStates.error));
    });

    test('selectedDropdownItem should be set correctly', () {
      String? expectedValue = 'Test Value';
      controller!.selectedDropdownItem = expectedValue;
      expect(controller!.selectedDropdownItem, expectedValue);
    });

    test('inProgress should be false by default', () {
      expect(controller!.inProgress, false);
    });

    test('inProgress should be true when set to true', () {
      controller!.inProgress = true;

      expect(controller!.inProgress, true);
    });

    test('Test dropdownItems', () {
      expect(controller!.dropdownItems[0].value, 'In Development');
      expect(controller!.dropdownItems[1].value, 'Open');
    });
  });
}

import 'package:admin/models/dashboard_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

enum DashboardStates { loading, loaded, error }

class DashBoardController extends ChangeNotifier {
  DashBoardController() {
    getDashboardElements();
  }
  DatabaseReference database = FirebaseDatabase.instance.ref();
  DashboardStates? _state;
  DashboardStates? get state => _state;
  set state(DashboardStates? value) {
    _state = value;
    notifyListeners();
  }

  int? _percentageSum = 0;
  int? get percentageSum => _percentageSum;

  List<DashboardElements>? _dashboardElements;
  List<DashboardElements>? get dashboardElements => _dashboardElements;

  List<DashboardElements>? _inProgressDashboardElements = [];
  List<DashboardElements>? get inProgressDashboardElements =>
      _inProgressDashboardElements;

  bool _inProgress = false;
  bool get inProgress => _inProgress;
  set inProgress(bool value) {
    _inProgress = value;
    notifyListeners();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text('In Development'), value: 'In Development'),
      const DropdownMenuItem(child: Text('Open'), value: "Open"),
    ];
    return menuItems;
  }

  String? _selectedDropdownItem;
  String? get selectedDropdownItem => _selectedDropdownItem;
  set selectedDropdownItem(String? value) {
    _selectedDropdownItem = value;
    notifyListeners();
  }

  Future<List<DashboardElements?>> getDashboardElements() async {
    try {
      state = DashboardStates.loading;
      _dashboardElements = [];
      _inProgressDashboardElements = [];
      _percentageSum = 0;
      var snapShot = await database.child('dashboardmodel').once();

      _dashboardElements = (snapShot.snapshot.value as Map<dynamic, dynamic>)
          .values
          .toList()
          .map((e) => DashboardElements.fromMap(e as Map<dynamic, dynamic>))
          .toList();

      for (var element in _dashboardElements!) {
        _percentageSum = _percentageSum! + element.completion!;
        if (element.inProgress == true) {
          inProgressDashboardElements!.add(element);
        }
      }
      state = DashboardStates.loaded;
    } catch (e) {
      state = DashboardStates.error;
    }

    return _dashboardElements!;
  }

  Future<void> addNewFeature(DashboardElements elements) async {
    try {
      state = DashboardStates.loading;
      await FirebaseDatabase.instance
          .ref('dashboardmodel')
          .push()
          .set(elements.toMap());
      state = DashboardStates.loaded;
    } catch (e) {
      state = DashboardStates.error;
    }
  }

  Future<void> updateFeature(DashboardElements elements) async {
    try {
      state = DashboardStates.loading;
      var dataRef = FirebaseDatabase.instance.ref().child("dashboardmodel");
      var snapshot = await dataRef
          .orderByChild("featurename")
          .equalTo(elements.featureName)
          .once();

      Map map = snapshot.snapshot.value as Map<dynamic, dynamic>;
      String key = map.keys.first;
      await dataRef.child(key).set(elements.toMap());
      state = DashboardStates.loaded;
    } catch (e) {
      state = DashboardStates.error;
    }
  }
}

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

  final List<DashboardElements>? _inProgressDashboardElements = [];
  List<DashboardElements>? get inProgressDashboardElements =>
      _inProgressDashboardElements;

  Future<List<DashboardElements?>> getDashboardElements() async {
    try {
      state = DashboardStates.loading;
      var snapShot = await database.child('dashboardmodel').get();

      _dashboardElements = (snapShot.value as List)
          .map((e) => DashboardElements.fromMap(e))
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
}

import 'package:admin/models/dashboard_model.dart';

final mockDashboardElements = {
  "-NPazsK8pxM1G7tvF8g2": {
    "completion": 10,
    "featurename": "example feature",
    "inProgress": false,
    "status": "In Development"
  },
  "-NPbPGjOjWoDboakTjGi": {
    "completion": 2,
    "featurename": "onur123",
    "inProgress": false,
    "status": "In Development"
  },
  "-NPbdm5zsTpYv9wNtT8p": {
    "completion": 32,
    "featurename": "test last",
    "inProgress": false,
    "status": "Open"
  },
  "-NPbmfYMypDNiG78QIhe": {
    "completion": 15,
    "featurename": "test feature",
    "inProgress": false,
    "status": "Open"
  },
  "-NPqtC-ZyHJjQu85ZS7F": {
    "completion": 35,
    "featurename": "test feature",
    "inProgress": true,
    "status": "In Development"
  }
};

DashboardElements fakeDashboardModel = DashboardElements(
  featureName: 'onur123',
  inProgress: true,
  status: 'Open',
  completion: 5,
);

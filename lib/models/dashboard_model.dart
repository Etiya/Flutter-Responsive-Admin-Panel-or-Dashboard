class DashboardModel {
  DashboardModel({
    this.items,
  });

   Map<String, DashboardElements>? items;

  DashboardModel.fromMap(Map<dynamic, dynamic> map)
      : items = map['dashboardmodel'];
}
class DashboardElements {
  DashboardElements({
    this.completion,
    this.featureName,
    this.inProgress,
    this.status,
  });

  int? completion;
  String? featureName;
  bool? inProgress;
  String? status;

  DashboardElements.fromMap(Map<dynamic, dynamic> map)
      : completion = map['completion'],
        featureName = map['featurename'],
        inProgress = map["inProgress"],
        status = map["status"];

  Map<dynamic, dynamic> toMap() {
    return {
      'completion': completion,
      'featurename': featureName,
      'inProgress': inProgress,
      'status': status,
    };
  }
}

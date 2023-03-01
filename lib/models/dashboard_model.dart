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
}

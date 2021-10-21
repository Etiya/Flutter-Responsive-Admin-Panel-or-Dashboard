import 'package:platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionMetadata {
  String? appStoreId;
  // String? minRequiredIOSVersion;
  // String? minRequiredAndroidVersion;

  String? minRequiredIOSAppVersion;
  String? minRequiredAndroidAppVersion;

  String? latestPublishedIOSVersion;
  String? latestPublishedAndroidVersion;

  AppVersionMetadata({
    this.appStoreId,
    // this.minRequiredIOSVersion,
    // this.minRequiredAndroidVersion,
    this.minRequiredIOSAppVersion,
    this.minRequiredAndroidAppVersion,
    this.latestPublishedIOSVersion,
    this.latestPublishedAndroidVersion,
  });

  factory AppVersionMetadata.fromJson(Map<String, dynamic> json) => AppVersionMetadata(
    appStoreId: json["app-store-id"],
    minRequiredIOSAppVersion: json["min-required-ios-app-version"],
    minRequiredAndroidAppVersion: json["min-required-android-app-version"],
    latestPublishedIOSVersion: json["latest-published-ios-version"],
    latestPublishedAndroidVersion: json["latest-published-android-version"],
  );

  Map<String, dynamic> toJson() => {
    "app-store-id": appStoreId,
    "min-required-ios-app-version": minRequiredIOSAppVersion,
    "min-required-android-app-version": minRequiredAndroidAppVersion,
    "latest-published-ios-version": latestPublishedIOSVersion,
    "latest-published-android-version": latestPublishedAndroidVersion,
  };

  Platform platform = const LocalPlatform();
  bool get isAndroid => platform.isAndroid;
  bool get isIOS => platform.isIOS;

  bool _isThereAnyAvailableUpdate = false;
  bool _isUserHasToForceUpdate = false;

  Future<bool> isUserHasToForceUpdate() async {
    await _calculate();
    return _isUserHasToForceUpdate;
  }

  Future<bool> isThereAnyUpdateAvailable() async {
    await _calculate();
    return _isThereAnyAvailableUpdate;
  }

  Future<void> _calculate() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final int currentVersion = int.tryParse(packageInfo.version.trimNonNumeric) ?? -1;
    final int latestIOSVersion = int.tryParse(latestPublishedIOSVersion?.trimNonNumeric ?? "0") ?? -1;
    final int latestAndroidVersion = int.tryParse(latestPublishedAndroidVersion?.trimNonNumeric ?? "0") ?? -1;

    _isUserHasToForceUpdate = false;
    _isThereAnyAvailableUpdate = false;

    if (isAndroid) {
      // Already have latest version
      if (currentVersion >= latestAndroidVersion) {
        return;
      }

      final int _minRequiredAndroidAppVersion = int.tryParse(minRequiredAndroidAppVersion?.trimNonNumeric ?? "0") ?? -1;
      if (currentVersion < _minRequiredAndroidAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredAndroidAppVersion && currentVersion < latestAndroidVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    } else if(isIOS) {
      // Already have latest version
      if (currentVersion >= latestIOSVersion) {
        return;
      }

      final int _minRequiredIOSAppVersion = int.tryParse(minRequiredIOSAppVersion?.trimNonNumeric ?? "0") ?? -1;
      if (currentVersion < _minRequiredIOSAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredIOSAppVersion && currentVersion < latestIOSVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    }
  }
}

extension GetNumeric on String {
  String get trimNonNumeric => replaceAll(RegExp(r'[^\d]'), "");
}

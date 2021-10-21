import 'package:platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionMetadata {
  String? appStoreID;
  String? minRequiredIOSVersion;
  String? minRequiredAndroidVersion;

  String? minRequiredIOSAppVersion;
  String? minRequiredAndroidAppVersion;

  String? latestAvailableVersion;

  AppVersionMetadata({
    this.appStoreID,
    this.minRequiredIOSVersion,
    this.minRequiredAndroidVersion,
    this.minRequiredIOSAppVersion,
    this.minRequiredAndroidAppVersion,
    this.latestAvailableVersion,
  });

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
    final int latestVersion = int.tryParse(latestAvailableVersion?.trimNonNumeric ?? "0") ?? -1;

    _isUserHasToForceUpdate = false;
    _isThereAnyAvailableUpdate = false;

    // Already have latest version
    if (currentVersion >= latestVersion) {
      return;
    }

    if (isAndroid) {
      final int _minRequiredAndroidAppVersion = int.tryParse(minRequiredAndroidAppVersion?.trimNonNumeric ?? "0") ?? -1;
      if (currentVersion < _minRequiredAndroidAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredAndroidAppVersion && currentVersion < latestVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    } else if(isIOS) {
      final int _minRequiredIOSAppVersion = int.tryParse(minRequiredIOSAppVersion?.trimNonNumeric ?? "0") ?? -1;
      if (currentVersion < _minRequiredIOSAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredIOSAppVersion && currentVersion < latestVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    }
  }
}

extension GetNumeric on String {
  String get trimNonNumeric => replaceAll(RegExp(r'[^\d]'), "");
}

import 'package:platform/platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

/*
Sample JSON
{
  "app-version-update": {
    "configuration": {
      "update-button-text": "Update",
      "not-now-button-text": "Not now"
    },
    "ios": {
      "app-id": "585027354",
      "latest-published-version": "2.3.0",
      "min-required-app-version": "2.0.0",
      "new-release-information": {
        "title": "New Release is available",
        "description": "Here new release contains this this and this"
      }
    },
    "android": {
      "app-id": "com.iyaffle.kural",
      "latest-published-version": "1.2.0",
      "min-required-app-version": "1.2.0",
      "new-release-information": {
        "title": "New Release is available",
        "description": "Here new release contains this this and this"
      }
    }
  }
}
 */

class AppPlatform {
  AppPlatform({
    required this.appId,
    required this.latestPublishedVersion,
    required this.minRequiredAppVersion,
    required this.newReleaseInformation,
  });

  String? appId;
  String? latestPublishedVersion;
  String? minRequiredAppVersion;
  NewReleaseInformation? newReleaseInformation;

  factory AppPlatform.fromJson(Map<String, dynamic>? json) => AppPlatform(
        appId: json?["app-id"],
        latestPublishedVersion: json?["latest-published-version"],
        minRequiredAppVersion: json?["min-required-app-version"],
        newReleaseInformation:
            NewReleaseInformation.fromJson(Map<String, dynamic>.from(json?["new-release-information"])),
      );

  Map<String, dynamic> toJson() => {
        "app-id": appId,
        "latest-published-version": latestPublishedVersion,
        "min-required-app-version": minRequiredAppVersion,
        "new-release-information": newReleaseInformation?.toJson(),
      };
}

class NewReleaseInformation {
  NewReleaseInformation({
    required this.title,
    required this.description,
  });

  String? title;
  String? description;

  factory NewReleaseInformation.fromJson(Map<String, dynamic>? json) =>
      NewReleaseInformation(
        title: json?["title"],
        description: json?["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Configuration {
  Configuration({
    required this.updateButtonText,
    required this.notNowButtonText,
  });

  String? updateButtonText;
  String? notNowButtonText;

  factory Configuration.fromJson(Map<String, dynamic>? json) => Configuration(
        updateButtonText: json?["update-button-text"],
        notNowButtonText: json?["not-now-button-text"],
      );

  Map<String, dynamic> toJson() => {
        "update-button-text": updateButtonText,
        "not-now-button-text": notNowButtonText,
      };
}

class AppVersionMetadata {
  Configuration? configuration;
  AppPlatform? iosApp;
  AppPlatform? androidApp;

  AppVersionMetadata({
    required this.configuration,
    required this.iosApp,
    required this.androidApp,
  });

  factory AppVersionMetadata.fromJson(Map<String, dynamic>? json) =>
      AppVersionMetadata(
        configuration: Configuration.fromJson(Map<String, dynamic>.from(json?["configuration"])),
        iosApp: AppPlatform.fromJson(Map<String, dynamic>.from(json?["ios"])),
        androidApp: AppPlatform.fromJson(Map<String, dynamic>.from(json?["android"])),
      );

  Map<String, dynamic> toJson() => {
        "ios": iosApp?.toJson(),
        "android": androidApp?.toJson(),
        "configuration": configuration?.toJson()
      };

  Platform platform = const LocalPlatform();

  bool get isAndroid => platform.isAndroid;

  bool get isIOS => platform.isIOS;

  bool _isThereAnyAvailableUpdate = false;
  bool _isUserHasToForceUpdate = false;

  NewReleaseInformation? get currentReleaseInformation => isAndroid
      ? androidApp?.newReleaseInformation
      : iosApp?.newReleaseInformation;

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
    final int currentVersion =
        int.tryParse(packageInfo.version.trimNonNumeric) ?? -1;
    final int latestIOSVersion =
        int.tryParse(iosApp?.latestPublishedVersion?.trimNonNumeric ?? "0") ??
            -1;
    final int latestAndroidVersion = int.tryParse(
            androidApp?.latestPublishedVersion?.trimNonNumeric ?? "0") ??
        -1;

    _isUserHasToForceUpdate = false;
    _isThereAnyAvailableUpdate = false;

    if (isAndroid) {
      // Already have latest version
      if (currentVersion >= latestAndroidVersion) {
        return;
      }

      final int _minRequiredAndroidAppVersion = int.tryParse(
              androidApp?.minRequiredAppVersion?.trimNonNumeric ?? "0") ??
          -1;
      if (currentVersion < _minRequiredAndroidAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredAndroidAppVersion &&
          currentVersion < latestAndroidVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    } else if (isIOS) {
      // Already have latest version
      if (currentVersion >= latestIOSVersion) {
        return;
      }

      final int _minRequiredIOSAppVersion =
          int.tryParse(iosApp?.minRequiredAppVersion?.trimNonNumeric ?? "0") ??
              -1;
      if (currentVersion < _minRequiredIOSAppVersion) {
        _isUserHasToForceUpdate = true;
        _isThereAnyAvailableUpdate = true;
      } else if (currentVersion >= _minRequiredIOSAppVersion &&
          currentVersion < latestIOSVersion) {
        _isUserHasToForceUpdate = false;
        _isThereAnyAvailableUpdate = true;
      }
    }
  }
}

extension GetNumeric on String {
  String get trimNonNumeric => replaceAll(RegExp(r'[^\d]'), "");
}

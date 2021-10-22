import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

class AppVersionPopup {
  static showIfNeeded({
    required AppVersionMetadata appVersion,
    required BuildContext context,
  }) async {
    final isThereAnyUpdateAvailable =
        await appVersion.isThereAnyUpdateAvailable();
    final isUserHasToForceUpdate = await appVersion.isUserHasToForceUpdate();

    if (!isThereAnyUpdateAvailable) {
      return;
    }

    showDialog(
      barrierDismissible: !isUserHasToForceUpdate,
      context: context,
      builder: (_) => Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (appVersion.currentReleaseInformation?.title != null)
                  ...[
                    Text(
                      appVersion.currentReleaseInformation?.title ?? "",
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    const Divider()
                  ],
                Text(
                  appVersion.currentReleaseInformation?.description ?? "",
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    if (!isUserHasToForceUpdate)
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          appVersion.configuration?.notNowButtonText ?? "Not now",
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        LaunchReview.launch(
                          androidAppId: appVersion.androidApp?.appId,
                          iOSAppId: appVersion.iosApp?.appId,
                        );
                      },
                      child: Text(
                        appVersion.configuration?.updateButtonText ?? "Update",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

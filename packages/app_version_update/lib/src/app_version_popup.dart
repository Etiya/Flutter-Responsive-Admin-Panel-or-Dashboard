import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/material.dart';

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
      builder: (_) =>
          Dialog(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.orangeAccent,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      softWrap: true,
                    ),
                    Row(
                      children: [
                        if (!isUserHasToForceUpdate)
                          TextButton(onPressed: () {}, child: Text("Not now")),
                        TextButton(onPressed: () {}, child: Text("Update")),
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

import 'package:admin/controllers/menu_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_version_update/app_version_update.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../responsive.dart';

class AppVersionScreen extends StatefulWidget {
  const AppVersionScreen({Key? key}) : super(key: key);

  @override
  AppVersionScreenState createState() => AppVersionScreenState();
}

class AppVersionScreenState extends State<AppVersionScreen> {
  final DatabaseReference db = FirebaseDatabase(app: app).reference();
  final _formKey = GlobalKey<FormState>();

  // Configuration Section
  TextEditingController updateButtonTextController = TextEditingController();
  TextEditingController notNowButtonTextController = TextEditingController();

  // iOS Section
  TextEditingController minRequiredIOSAppVersionController = TextEditingController();
  TextEditingController latestAvailableIOSAppVersionController = TextEditingController();
  TextEditingController iOSAppID = TextEditingController();
  TextEditingController iOSReleaseInformationTitleController = TextEditingController();
  TextEditingController iOSReleaseInformationDescriptionController = TextEditingController();

  // Android Section
  TextEditingController minRequiredAndroidAppVersionController = TextEditingController();
  TextEditingController latestAvailableAndroidAppVersionController = TextEditingController();
  TextEditingController androidAppID = TextEditingController();
  TextEditingController androidReleaseInformationTitleController = TextEditingController();
  TextEditingController androidReleaseInformationDescriptionController = TextEditingController();

  AppVersionMetadata? appVersion;

  @override
  void initState() {
    super.initState();
    db.child("app-version-update").once().then((snapshot) {
      appVersion = AppVersionMetadata.fromJson(Map<String, dynamic>.from(snapshot.value));
      // Configuration
      updateButtonTextController.text = appVersion?.configuration?.updateButtonText ?? "";
      notNowButtonTextController.text = appVersion?.configuration?.notNowButtonText ?? "";
      // iOS
      minRequiredIOSAppVersionController.text = appVersion?.iosApp?.minRequiredAppVersion ?? "";
      latestAvailableIOSAppVersionController.text = appVersion?.iosApp?.latestPublishedVersion ?? "";
      iOSAppID.text = appVersion?.iosApp?.appId ?? "";
      iOSReleaseInformationTitleController.text = appVersion?.iosApp?.newReleaseInformation?.title ?? "";
      iOSReleaseInformationDescriptionController.text = appVersion?.iosApp?.newReleaseInformation?.description ?? "";
      // Android
      minRequiredAndroidAppVersionController.text = appVersion?.androidApp?.minRequiredAppVersion ?? "";
      latestAvailableAndroidAppVersionController.text = appVersion?.androidApp?.latestPublishedVersion ?? "";
      androidAppID.text = appVersion?.androidApp?.appId ?? "";
      androidReleaseInformationTitleController.text = appVersion?.androidApp?.newReleaseInformation?.title ?? "";
      androidReleaseInformationDescriptionController.text = appVersion?.androidApp?.newReleaseInformation?.description ?? "";
      debugPrint(appVersion.toString());
    });
  }

  saveChangesToDB() async {
    final AppVersionMetadata? updated = appVersion;
    // Configuration
    updated?.configuration?.updateButtonText = updateButtonTextController.text;
    updated?.configuration?.notNowButtonText = notNowButtonTextController.text;
    // iOS
    updated?.iosApp?.minRequiredAppVersion = minRequiredIOSAppVersionController.text;
    updated?.iosApp?.latestPublishedVersion = latestAvailableIOSAppVersionController.text;
    updated?.iosApp?.appId = iOSAppID.text;
    updated?.iosApp?.newReleaseInformation?.title = iOSReleaseInformationTitleController.text;
    updated?.iosApp?.newReleaseInformation?.description = iOSReleaseInformationDescriptionController.text;
    // Android
    updated?.androidApp?.minRequiredAppVersion = minRequiredAndroidAppVersionController.text;
    updated?.androidApp?.latestPublishedVersion = latestAvailableAndroidAppVersionController.text;
    updated?.androidApp?.appId = androidAppID.text;
    updated?.androidApp?.newReleaseInformation?.title = androidReleaseInformationTitleController.text;
    updated?.androidApp?.newReleaseInformation?.description = androidReleaseInformationDescriptionController.text;
    await db.child("app-version-update").set(appVersion?.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes Saved')),
    );
  }

  List<Widget> configurationSection() {
    return [
      SizedBox(
        width: double.infinity,
        child: Text("Configuration", style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.start,),
      ),
      const Divider(),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Update Button Text',
        ),
        controller: updateButtonTextController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Not now Button Text'
        ),
        controller: notNowButtonTextController,
      ),
      const SizedBox(
        height: 32,
      ),
    ];
  }

  List<Widget> iOSSection() {
    return [
      SizedBox(
        width: double.infinity,
        child: Text("iOS", style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.start,),
      ),
      const Divider(),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Minimum Required iOS App Version',
            hintText: "x.x.x"),
        controller: minRequiredIOSAppVersionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'iOS App Version on store', hintText: "x.x.x"),
        controller: latestAvailableIOSAppVersionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'iOS App Release Note Title'),
        controller: iOSReleaseInformationTitleController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'iOS App Release Note Description'),
        controller: iOSReleaseInformationDescriptionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'iOS App ID', hintText: "1546984240"),
        controller: iOSAppID,
      ),
      const SizedBox(
        height: 32,
      ),
    ];
  }

  List<Widget> androidSection() {
    return [
      SizedBox(
        width: double.infinity,
        child: Text("Android", style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.start,),
      ),
      const Divider(),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Minimum Required Android App Version',
            hintText: "x.x.x"),
        controller: minRequiredAndroidAppVersionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Android App Version on store',
            hintText: "x.x.x"),
        controller: latestAvailableAndroidAppVersionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Android App Release Note Title'),
        controller: androidReleaseInformationTitleController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Android App Release Note Description'),
        controller: androidReleaseInformationDescriptionController,
      ),
      const SizedBox(
        height: 16,
      ),
      TextFormField(
        decoration: const InputDecoration(
            labelText: 'Android App ID', hintText: "1546984240"),
        controller: androidAppID,
      ),
      const SizedBox(
        height: 16,
      ),
    ];
  }

  Widget saveButton() => ElevatedButton(
    onPressed: () {
      if (_formKey.currentState!.validate()) {
        saveChangesToDB();
      }
    },
    child: const Text('Save'),
  );

  Widget dataBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...configurationSection(),
                ...iOSSection(),
                ...androidSection(),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: context
                    .read<MenuController>()
                    .controlMenu,
              ),
          ],
        ),
        title: const Text("App Version"),
      ),
      body: dataBody(),
    );
  }
}
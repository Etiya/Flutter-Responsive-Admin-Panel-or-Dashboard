import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_version_update/app_version_update.dart';

import '../../main.dart';

class AppVersionScreen extends StatefulWidget {
  const AppVersionScreen({Key? key}): super(key: key);

  @override
  AppVersionScreenState createState() => AppVersionScreenState();
}

class AppVersionScreenState extends State<AppVersionScreen> {

  final DatabaseReference db = FirebaseDatabase(app: app).reference();
  final _formKey = GlobalKey<FormState>();

  TextEditingController minRequiredIOSAppVersionController = TextEditingController();
  TextEditingController minRequiredAndroidAppVersionController = TextEditingController();
  TextEditingController latestAvailableIOSAppVersionController = TextEditingController();
  TextEditingController latestAvailableAndroidAppVersionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db.child("app-version-update").once().then((value) {
      final AppVersionMetadata appVersion = AppVersionMetadata.fromJson(value.value);
      minRequiredIOSAppVersionController.text = appVersion.minRequiredIOSAppVersion ?? "";
      minRequiredAndroidAppVersionController.text = appVersion.minRequiredAndroidAppVersion ?? "";
      latestAvailableIOSAppVersionController.text = appVersion.latestPublishedIOSVersion ?? "";
      latestAvailableAndroidAppVersionController.text = appVersion.latestPublishedAndroidVersion ?? "";
      debugPrint(appVersion.toString());
    });
  }

  saveChangesToDB() async {
    final AppVersionMetadata appVersion = AppVersionMetadata();
    appVersion.minRequiredIOSAppVersion = minRequiredIOSAppVersionController.text;
    appVersion.minRequiredAndroidAppVersion = minRequiredAndroidAppVersionController.text;
    appVersion.latestPublishedIOSVersion = latestAvailableIOSAppVersionController.text;
    appVersion.latestPublishedAndroidVersion = latestAvailableAndroidAppVersionController.text;
    await db.child("app-version-update").set(appVersion.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes Saved')),
    );
  }

  Widget dataBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey), borderRadius: BorderRadius.circular(8)),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Minimum Required iOS App Version', hintText: "x.x.x"),
                    controller: minRequiredIOSAppVersionController,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Minimum Required Android App Version', hintText: "x.x.x"),
                  controller: minRequiredAndroidAppVersionController,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'iOS App Version on store', hintText: "x.x.x"),
                  controller: latestAvailableIOSAppVersionController,
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Android App Version on store', hintText: "x.x.x"),
                  controller: latestAvailableAndroidAppVersionController,
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveChangesToDB();
                    }
                  },
                  child: const Text('Save'),
                ),
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
        title: const Text("App Version"),
      ),
      body: dataBody(),
    );
  }
}
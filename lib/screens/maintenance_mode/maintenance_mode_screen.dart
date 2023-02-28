import 'package:admin/controllers/menu_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:maintenance_mode/maintenance_mode.dart';

import '../../main.dart';
import '../../responsive.dart';

class MaintenanceModeScreen extends StatefulWidget {
  const MaintenanceModeScreen({Key? key}) : super(key: key);

  @override
  MaintenanceModeScreenState createState() => MaintenanceModeScreenState();
}

class MaintenanceModeScreenState extends State<MaintenanceModeScreen> {
  final DatabaseReference db = FirebaseDatabase(app: app).reference();
  final _formKey = GlobalKey<FormBuilderState>();

  MaintenanceMode? maintenanceMode;

  TextEditingController maintenanceDescriptionController =
      TextEditingController();
  bool isMaintenanceEnabled = false;

  @override
  void initState() {
    super.initState();
    db.child("maintenanceMode").once().then((event) {
        maintenanceMode = MaintenanceMode.fromJson(Map<String, dynamic>.from(event.snapshot.value as dynamic));
        setState(() {
          // TODO: initial enable setup does not work.
          isMaintenanceEnabled = maintenanceMode?.enabled ?? false;
          maintenanceDescriptionController.text = maintenanceMode?.maintenanceDescription ?? "";
        });
    });
  }

  saveChangesToDB() async {
    final MaintenanceMode? updated = maintenanceMode;
    updated?.enabled = isMaintenanceEnabled;
    updated?.maintenanceDescription = maintenanceDescriptionController.text;
    debugPrint("Maintenance Enabled = $isMaintenanceEnabled");
    debugPrint("Maintenance Description = ${maintenanceDescriptionController.text}");
    await db.child("maintenanceMode").set(maintenanceMode?.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes Saved')),
    );
  }

  List<Widget> configurationSection() {
    return [
      SizedBox(
        width: double.infinity,
        child: Text(
          "Configuration",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.start,
        ),
      ),
      const Divider(),
      FormBuilderField<bool>(
        name: 'enabled',
        builder: (FormFieldState<bool?> field) => SwitchListTile(
          contentPadding: const EdgeInsets.all(0),
            title: const Text('Enabled'),
            onChanged: (bool value) {
              field.didChange(value);
              isMaintenanceEnabled = value;
            },
            value: field.value ?? isMaintenanceEnabled,
          ),
      ),
      const SizedBox(
        height: 16,
      ),
      FormBuilderTextField(
        name: "maintenance_description",
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(labelText: "Maintenance Description"),
        controller: maintenanceDescriptionController,
      ),
      const SizedBox(
        height: 32,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...configurationSection(),
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
                onPressed: context.read<MenuControllers>().controlMenu,
              ),
          ],
        ),
        title: const Text("Maintenance Mode"),
      ),
      body: dataBody()
    );
  }
}

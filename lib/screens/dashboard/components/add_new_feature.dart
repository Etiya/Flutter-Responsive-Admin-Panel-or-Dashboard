import 'package:admin/constants.dart';
import 'package:admin/controllers/dashboard_controller.dart';
import 'package:admin/models/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum FeatureFormState { create, edit }

class AddNewFeature extends StatefulWidget {
  const AddNewFeature.create({
    Key? key,
    this.featureNameController,
    this.completionController,
    this.featureFormState = FeatureFormState.create,
  }) : super(key: key);

  const AddNewFeature.edit({
    Key? key,
    required this.featureNameController,
    required this.completionController,
    this.featureFormState = FeatureFormState.edit,
  }) : super(key: key);

  final TextEditingController? featureNameController;
  final TextEditingController? completionController;
  final FeatureFormState? featureFormState;

  @override
  State<AddNewFeature> createState() => _AddNewFeatureState();
}

class _AddNewFeatureState extends State<AddNewFeature> {
  final _fKey = GlobalKey<FormState>();
  late TextEditingController featureNameController;
  late TextEditingController completionController;

  @override
  void initState() {
    featureNameController =
        widget.featureNameController ?? TextEditingController();
    completionController =
        widget.completionController ?? TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _dashboardControllers = Provider.of<DashBoardController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: generateTitle(),
      ),
      body: Form(
        key: _fKey,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Feature Name'),
              10.verticalSpace,
              TextFormField(
                controller: widget.featureNameController,
                decoration: InputDecoration(
                    enabled: widget.featureFormState == FeatureFormState.create,
                    fillColor: bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)))),
                validator: (value) => value!.isEmpty ? 'field required' : null,
              ),
              20.verticalSpace,
              const Text('Completion'),
              10.verticalSpace,
              TextFormField(
                controller: widget.completionController,
                decoration: InputDecoration(
                    fillColor: bgColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)))),
                validator: (value) => value!.isEmpty ? 'field required' : null,
              ),
              20.verticalSpace,
              const Text('Status'),
              10.verticalSpace,
              DropdownButtonFormField(
                  validator: (value) => value == null ? 'field required' : null,
                  hint: const Text('Select Status'),
                  isExpanded: true,
                  items: _dashboardControllers.dropdownItems,
                  value: _dashboardControllers.selectedDropdownItem,
                  onChanged: (String? s) {
                    _dashboardControllers.selectedDropdownItem = s;
                  }),
              20.verticalSpace,
              const Text('In Progress'),
              10.verticalSpace,
              Switch.adaptive(
                  value: _dashboardControllers.inProgress,
                  onChanged: (s) {
                    _dashboardControllers.inProgress =
                        !_dashboardControllers.inProgress;
                  }),
              20.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: onPressed(),
                  child: const Text('Save'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor),
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40.r, vertical: 10.r)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  VoidCallback onPressed() {
    var _dashboardControllers = Provider.of<DashBoardController>(
      context,
      listen: false,
    );
    if (widget.featureFormState == FeatureFormState.create) {
      return () async {
        if (_fKey.currentState!.validate()) {
          await _dashboardControllers.addNewFeature(DashboardElements(
            completion: int.parse(completionController.text.toString()),
            featureName: featureNameController.text,
            status: _dashboardControllers.selectedDropdownItem,
            inProgress: _dashboardControllers.inProgress,
          ));
          Navigator.pop(context);
        }
      };
    } else {
      return () async {
        if (_fKey.currentState!.validate()) {
          await _dashboardControllers.updateFeature(DashboardElements(
            completion: int.parse(completionController.text.toString()),
            featureName: featureNameController.text,
            status: _dashboardControllers.selectedDropdownItem,
            inProgress: _dashboardControllers.inProgress,
          ));
          Navigator.pop(context);
        }
      };
    }
  }

  Text generateTitle() {
    if (widget.featureFormState == FeatureFormState.create) {
      return const Text('Add New Feature');
    } else {
      return const Text('Edit Feature');
    }
  }
}

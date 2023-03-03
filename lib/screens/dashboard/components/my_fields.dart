import 'package:admin/controllers/dashboard_controller.dart';
import 'package:admin/models/my_files.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/add_new_feature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    var _dashboarControllers = Provider.of<DashBoardController>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "In-Progress Features",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: ((context) => ChangeNotifierProvider(
                              create: (context) => DashBoardController(),
                              child: AddNewFeature.create(
                                featureNameController: TextEditingController(),
                                completionController: TextEditingController(),
                              ),
                            )))).then((value) async {
                  await _dashboarControllers.getDashboardElements();
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: _dashboarControllers.state == DashboardStates.loading
              ? const Center(child: CircularProgressIndicator())
              : _dashboarControllers.state == DashboardStates.loaded
                  ? FileInfoCardGridView(
                      crossAxisCount: _size.width < 650 ? 2 : 4,
                      childAspectRatio:
                          _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                    )
                  : const Center(
                      child: Text('Error'),
                    ),
          tablet: _dashboarControllers.state == DashboardStates.loading
              ? const Center(child: CircularProgressIndicator())
              : _dashboarControllers.state == DashboardStates.loaded
                  ? const FileInfoCardGridView()
                  : const Center(
                      child: Text('Error'),
                    ),
          desktop: _dashboarControllers.state == DashboardStates.loading
              ? const Center(child: CircularProgressIndicator())
              : _dashboarControllers.state == DashboardStates.loaded
                  ? FileInfoCardGridView(
                      childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                    )
                  : const Center(
                      child: Text('Error'),
                    ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    var _dashboardControllers = Provider.of<DashBoardController>(context);
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _dashboardControllers.inProgressDashboardElements!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          return FileInfoCard(
            info: CloudStorageInfo(
              title: _dashboardControllers
                  .inProgressDashboardElements![index].featureName,
              percentage: _dashboardControllers
                  .inProgressDashboardElements![index].completion,
              svgSrc: "assets/icons/Documents.svg",
              color: primaryColor,
            ),
            onTap: () async {
              _dashboardControllers.inProgress = _dashboardControllers
                  .inProgressDashboardElements![index].inProgress!;
              _dashboardControllers.selectedDropdownItem = _dashboardControllers
                  .inProgressDashboardElements![index].status;
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: ((context) => AddNewFeature.edit(
                            featureNameController: TextEditingController(
                                text: _dashboardControllers
                                    .inProgressDashboardElements![index]
                                    .featureName),
                            completionController: TextEditingController(
                                text: _dashboardControllers
                                    .inProgressDashboardElements![index]
                                    .completion
                                    .toString()),
                          )))).then((value) async {
                await _dashboardControllers.getDashboardElements();
              });
            },
          );
        });
  }
}

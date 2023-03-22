import 'package:admin/controllers/dashboard_controller.dart';
import 'package:admin/models/recent_file.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dashboardControllers = Provider.of<DashBoardController>(context);
    return Container(
      height: 260,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mobile App Admin Panel Goals",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          if (_dashboardControllers.state == DashboardStates.loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_dashboardControllers.state == DashboardStates.loaded)
            SizedBox(
              height: 200,
              width: double.infinity,
              child: DataTable2(
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: const [
                  DataColumn(
                    label: Text("Feature Name"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                ],
                rows: List.generate(
                  _dashboardControllers.dashboardElements!.length,
                  (index) => recentFileDataRow(RecentFile(
                    title: _dashboardControllers
                        .dashboardElements![index].featureName,
                    icon: "assets/icons/xd_file.svg",
                    status:
                        _dashboardControllers.dashboardElements![index].status,
                  )),
                ),
              ),
            ),
          if (_dashboardControllers.state == DashboardStates.error)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  fileInfo.title!,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.status!)),
      // DataCell(Text(fileInfo.size!)),
    ],
  );
}

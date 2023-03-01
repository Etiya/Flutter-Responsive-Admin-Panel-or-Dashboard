import 'package:admin/controllers/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dashboardControllers = Provider.of<DashBoardController>(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Status Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: defaultPadding),
          if (_dashboardControllers.state == DashboardStates.loaded) ...[
            Chart(
                paiChartSelectionDatas:
                    _dashboardControllers.dashboardElements!.map((e) {
              return PieChartSectionData(
                color: Color.fromARGB(
                    255,
                    math.Random().nextInt(200) + 55,
                    math.Random().nextInt(200) + 55,
                    math.Random().nextInt(200) + 55),
                title: e.featureName!,
                value: double.tryParse(e.completion.toString()),
                showTitle: false,
                radius: double.tryParse((math.Random().nextInt(10) + 10).toString()),
              );
            }).toList()),
            ListView(
                shrinkWrap: true,
                children: _dashboardControllers.dashboardElements!.map((e) {
                  return StorageInfoCard(
                    svgSrc: "assets/icons/unknown.svg",
                    title: e.featureName!,
                    percentage: e.completion!.toString(),
                    numOfFiles: 140,
                  );
                }).toList()),
          ],
          if (_dashboardControllers.state == DashboardStates.loading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_dashboardControllers.state == DashboardStates.error)
            const Center(
              child: Text('Error'),
            )
        ],
      ),
    );
  }
}

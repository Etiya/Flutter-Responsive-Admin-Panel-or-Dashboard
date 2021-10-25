import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String? svgSrc, title;
  final int? percentage;
  final Color? color;

  const CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.percentage,
    this.color,
  });
}

List demoMyFiles = [
  const CloudStorageInfo(
    title: "Localization",
    svgSrc: "assets/icons/Documents.svg",
    color: primaryColor,
    percentage: 35,
  ),
  const CloudStorageInfo(
    title: "Maintenance Mode",
    svgSrc: "assets/icons/google_drive.svg",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  const CloudStorageInfo(
    title: "App Rating View",
    svgSrc: "assets/icons/one_drive.svg",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  const CloudStorageInfo(
    title: "Basic Configurations",
    svgSrc: "assets/icons/drop_box.svg",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];

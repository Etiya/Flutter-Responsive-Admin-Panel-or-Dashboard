class RecentFile {
  final String? icon, title, status;

  RecentFile({this.icon, this.title, this.status});
}

List demoRecentFiles = [
  RecentFile(
    icon: "assets/icons/xd_file.svg",
    title: "Notification Manager",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Force Update",
    status: "Dev. Completed",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Localization",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    title: "Theme Management",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    title: "Basic Configurations \n(Enable/Disable - Show/Hide)",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    title: "Privacy Policies vs. Terms \n& Conditions Management",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "Maintenance Mode",
    status: "In Development",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "App Rating View",
    status: "Open",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "What’s New in this version",
    status: "Open",
  ),
];

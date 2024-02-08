import 'package:flacer/pages/apt_repository_manager_page.dart';
import 'package:flacer/pages/dashboard_page.dart';
import 'package:flacer/pages/gnome_settings_page.dart';
import 'package:flacer/pages/helpers_page.dart';
import 'package:flacer/pages/processes_page.dart';
import 'package:flacer/pages/resources_page.dart';
import 'package:flacer/pages/search_page.dart';
import 'package:flacer/pages/services_page.dart';
import 'package:flacer/pages/settings_page.dart';
import 'package:flacer/pages/startup_apps_page.dart';
import 'package:flacer/pages/system_cleaner_page.dart';
import 'package:flacer/pages/unistaller_page.dart';
import 'package:flutter/material.dart';
import 'package:yaru_icons/yaru_icons.dart';

class AppRoutesConfig {
  static Map<String, Widget> routePages = {
    "Dashboard": const DashboardPage(),
    "Startup Apps": const StartupAppsPage(),
    "System Cleaner": const SystemCleanerPage(),
    "Search": const SearchPage(),
    "Services": const ServicesPage(),
    "Processes": const ProcessesPage(),
    "Unistaller": const UnistallerPage(),
    "Resources": const ResourcesPage(),
    "Helpers": const HelpersPage(),
    "APT Repository Manager": const APTRepositoryManagerPage(),
    "Gnome Settings": const GnomeSettingsPage(),
    "Settings": const SettingsPage(),
  };

  static Map<String, IconData> routesIcons = routesIcons = {
    "Dashboard": YaruIcons.keyboard_shortcuts_filled,
    "Startup Apps": YaruIcons.dialpad_filled,
    "System Cleaner": YaruIcons.trash_full_filled,
    "Search": YaruIcons.search_filled,
    "Services": YaruIcons.gears,
    "Processes": YaruIcons.server_filled,
    "Unistaller": YaruIcons.trash_filled,
    "Resources": YaruIcons.monitor_filled,
    "Helpers": YaruIcons.wrench,
    "APT Repository Manager": YaruIcons.flatpak,
    "Gnome Settings": YaruIcons.gnome_logo,
    "Settings": YaruIcons.settings,
  };
}

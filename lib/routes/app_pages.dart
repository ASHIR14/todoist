import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoist/features/kanban_board/screen/kanban_board_screen.dart';
import 'package:todoist/features/kanban_board/screen/kanban_board_screen_bindings.dart';
import 'package:todoist/features/settings/screen/settings_screen.dart';
import 'package:todoist/features/settings/screen/settings_screen_bindings.dart';
import 'package:todoist/routes/app_routes.dart';

GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();

class AppPages {
  AppPages._();

  static const initial = Routes.kanbanBoardScreen;

  static final routes = [
    _buildPage(
      name: Routes.kanbanBoardScreen,
      page: const KanbanBoardScreen(),
      binding: KanbanBoardScreenBindings(),
    ),
    _buildPage(
      name: Routes.settingsScreen,
      page: const SettingsScreen(),
      binding: SettingsScreenBindings(),
    ),
  ];

  static GetPage _buildPage({
    required String name,
    required Widget page,
    Bindings? binding,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return GetPage(
      name: name,
      page: () => page,
      binding: binding,
      transitionDuration: transitionDuration,
    );
  }
}

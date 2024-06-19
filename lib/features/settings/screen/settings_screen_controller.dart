import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/settings/services/usecases/is_dark_mode_usecase.dart';
import 'package:todoist/features/settings/services/usecases/set_dark_mode_usecase.dart';

class SettingsScreenController extends GetxController {
  IsDarkModeUseCase isDarkModeUseCase;
  SetDarkModeUseCase setDarkModeUseCase;

  RxBool isDarkMode = false.obs;

  SettingsScreenController({
    required this.isDarkModeUseCase,
    required this.setDarkModeUseCase,
  });

  @override
  void onInit() {
    loadInitialData();
    super.onInit();
  }

  loadInitialData() async {
    final darkMode = await isDarkModeEnabled();
    isDarkMode(darkMode);
  }

  Future<bool> isDarkModeEnabled() async {
    final result = await isDarkModeUseCase(
      NoParams(),
    );
    bool isDarkMode = false;
    result.fold((left) {
      log("Error [isDarkModeEnabled]: ${left.message}");
    }, (right) {
      isDarkMode = right;
    });
    return Future.value(isDarkMode);
  }

  Future<void> toggleDarkMode({BuildContext? context}) async {
    if (isDarkMode.value) {
      isDarkMode.value = false;
      setDarkMode(false);
    } else {
      isDarkMode.value = true;
      setDarkMode(true);
    }
    Get.forceAppUpdate();
  }

  void setDarkMode(bool params) {
    setDarkModeUseCase(params);
  }
}

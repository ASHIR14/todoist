import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todoist/core/services/shared_preferences/shared_preferences_service.dart';
import 'package:todoist/routes/app_pages.dart';
import 'package:todoist/utils/constants/k_styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool themeMode = SharedPreferencesService.i.isDarkMode();
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: GetMaterialApp(
              navigatorKey: Get.key,
              useInheritedMediaQuery: true,
              title: 'Todoist',
              initialRoute: AppPages.initial,
              getPages: AppPages.routes,
              theme: KStyle.getTheme(),
              darkTheme: KStyle.getDarkTheme(),
              themeMode: themeMode ? ThemeMode.dark : ThemeMode.light,
              builder: EasyLoading.init(),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoist/app.dart';
import 'package:todoist/core/services/shared_preferences/shared_preferences_service.dart';
import 'package:todoist/utils/dependency_injection/initial_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await InitialBindings().onInit();

  runApp(const MyApp());
}

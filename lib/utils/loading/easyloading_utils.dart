import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void customizeLoading(BuildContext context) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Theme.of(context).colorScheme.onPrimary
    ..backgroundColor = Theme.of(context).colorScheme.onSecondary
    ..indicatorColor = Theme.of(context).colorScheme.onPrimary
    ..textColor = Theme.of(context).colorScheme.onPrimary
    ..maskColor = Theme.of(context).colorScheme.onSecondary.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false;
}

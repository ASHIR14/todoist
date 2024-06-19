import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoist/core/widgets/app_bar.dart';
import 'package:todoist/features/settings/screen/settings_screen_controller.dart';

class SettingsScreen extends GetView<SettingsScreenController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            leading: BackButton(),
            title: 'Settings',
            actions: [],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: (value) {
                      controller.toggleDarkMode();
                    },
                  ),
                ),
                // ListTile(
                //   title: const Text('Language'),
                //   trailing: const Icon(Icons.arrow_forward_ios),
                //   onTap: () {
                //     controller.changeLanguage();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:todoist/features/settings/screen/settings_screen_controller.dart';
import 'package:todoist/features/settings/services/repository/app_settings_repository.dart';
import 'package:todoist/features/settings/services/repository/app_settings_repository_impl.dart';
import 'package:todoist/features/settings/services/usecases/is_dark_mode_usecase.dart';
import 'package:todoist/features/settings/services/usecases/set_dark_mode_usecase.dart';

class SettingsScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppSettingRepository>(
      () => AppSettingRepositoryImpl(),
    );

    Get.lazyPut<IsDarkModeUseCase>(
      () => IsDarkModeUseCase(
        repository: Get.find<AppSettingRepository>(),
      ),
    );

    Get.lazyPut<SetDarkModeUseCase>(
      () => SetDarkModeUseCase(
        repository: Get.find<AppSettingRepository>(),
      ),
    );

    Get.lazyPut<SettingsScreenController>(
      () => SettingsScreenController(
        isDarkModeUseCase: Get.find<IsDarkModeUseCase>(),
        setDarkModeUseCase: Get.find<SetDarkModeUseCase>(),
      ),
    );
  }
}

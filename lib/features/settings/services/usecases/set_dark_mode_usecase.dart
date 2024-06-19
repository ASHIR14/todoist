import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/settings/services/repository/app_settings_repository.dart';

class SetDarkModeUseCase extends UseCase<bool, bool> {
  final AppSettingRepository _repository;

  SetDarkModeUseCase({required AppSettingRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(bool params) {
    return _repository.setDarkMode(params);
  }
}

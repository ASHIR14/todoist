import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/usecase/usecase.dart';
import 'package:todoist/features/settings/services/repository/app_settings_repository.dart';

class IsDarkModeUseCase extends UseCase<bool, NoParams> {
  final AppSettingRepository _repository;

  IsDarkModeUseCase({required AppSettingRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return _repository.isDarkMode();
  }
}

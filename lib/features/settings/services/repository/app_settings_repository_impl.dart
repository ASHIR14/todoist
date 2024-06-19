import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/services/shared_preferences/shared_preferences_service.dart';
import 'package:todoist/features/settings/services/repository/app_settings_repository.dart';

class AppSettingRepositoryImpl extends AppSettingRepository {
  AppSettingRepositoryImpl();

  @override
  Future<Either<Failure, bool>> setDarkMode(bool params) async {
    try {
      SharedPreferencesService.i.setDarkMode(params);
      return const Right(true);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isDarkMode() async {
    try {
      final result = SharedPreferencesService.i.isDarkMode();
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

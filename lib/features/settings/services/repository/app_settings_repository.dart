
import 'package:dartz/dartz.dart';
import 'package:todoist/core/model/failures.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, bool>> setDarkMode(bool params);

  Future<Either<Failure, bool>> isDarkMode();
}

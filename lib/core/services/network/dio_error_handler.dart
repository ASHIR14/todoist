import 'package:dio/dio.dart';
import 'package:todoist/core/model/failures.dart';

abstract class DioErrorHandler {
  Failure resolveErrors({required Response<dynamic> response});

  Failure throwDefaultFailure();
}

class DioErrorHandlerImpl extends DioErrorHandler {
  @override
  Failure resolveErrors({required Response<dynamic> response}) {
    switch (response.statusCode) {
      case 500:
        return const DioInternalError(message: "Internal Error");
      case 404:
        return const DioNotFoundError(message: "Not Found");
      case 204:
        return const DioContentNotFound(message: "Content Not Found");
      case 401:
        return const DioUnAuthorized(message: 'Unauthorized Request');
      case 422:
        return const ResultsNotFound(message: 'Results Not Found');
      case 503:
        return const ServiceUnavailableFailure(message: 'Unauthorized Request');
      default:
        return const DioDefaultFailure(message: 'Something Went Wrong');
    }
  }

  @override
  Failure throwDefaultFailure() {
    return const DioDefaultFailure(message: 'something_went_wrong');
  }
}

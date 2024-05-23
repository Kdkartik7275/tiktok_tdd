import 'package:tiktok_tdd/core/common/errors/failure.dart';

class ApiFailure extends Failure {
  ApiFailure({
    required super.message,
    required super.statusCode,
  });
}

import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';

abstract interface class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call(Params params);
}

abstract interface class UseCaseWithoutParams<Type> {
  ResultFuture<Type> call();
}

abstract interface class UseCaseWithParamsStream<Type, Params> {
  ResultStream<Type> call(Params params);
}

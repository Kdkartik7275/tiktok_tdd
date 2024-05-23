import 'package:fpdart/fpdart.dart';
import 'package:tiktok_tdd/core/common/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<T>;

typedef ResultVoid = Future<Either<Failure, void>>;

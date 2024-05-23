import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class FetchReels implements UseCaseWithoutParams<List<ReelEntity>> {
  final ReelRepository repository;

  FetchReels({required this.repository});
  @override
  ResultFuture<List<ReelEntity>> call() async => await repository.fetchReels();
}

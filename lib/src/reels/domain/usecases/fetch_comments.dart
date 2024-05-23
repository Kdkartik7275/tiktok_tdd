import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/domain/repository/reel_repository.dart';

class FetchComments implements UseCaseWithParams<List<CommentEntity>, String> {
  final ReelRepository repository;

  FetchComments({required this.repository});
  @override
  ResultFuture<List<CommentEntity>> call(String params) async =>
      await repository.fetchComments(videoId: params);
}

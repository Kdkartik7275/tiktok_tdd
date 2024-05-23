import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/repository/chat_repository.dart';

class CreateChatRoom
    implements UseCaseWithParams<ChatRoomEntity, CreateChatRoomParams> {
  final ChatRepository repository;

  CreateChatRoom({required this.repository});
  @override
  ResultFuture<ChatRoomEntity> call(CreateChatRoomParams params) async =>
      await repository.createChatRoom(
          userId: params.userId, myUserId: params.myUserId);
}

class CreateChatRoomParams {
  final String userId;
  final String myUserId;

  CreateChatRoomParams({required this.userId, required this.myUserId});
}

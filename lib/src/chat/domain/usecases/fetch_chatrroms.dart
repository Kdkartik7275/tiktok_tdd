import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/repository/chat_repository.dart';

class FetchChatRooms
    implements UseCaseWithParams<List<ChatRoomEntity>, String> {
  final ChatRepository repository;

  FetchChatRooms({required this.repository});
  @override
  ResultFuture<List<ChatRoomEntity>> call(String myUserId) async =>
      await repository.fetchChatRooms(myUserId: myUserId);
}

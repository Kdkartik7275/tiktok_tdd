import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';
import 'package:tiktok_tdd/src/chat/domain/repository/chat_repository.dart';

class ListenToMessages
    implements
        UseCaseWithParamsStream<List<MessageEntity>, ListenToMessagesParams> {
  final ChatRepository repository;

  ListenToMessages({required this.repository});
  @override
  Stream<List<MessageEntity>> call(ListenToMessagesParams params) =>
      repository.listenToMessages(
          chatRoomId: params.chatRoomId, myUserId: params.myUserId);
}

class ListenToMessagesParams {
  final String myUserId;
  final String chatRoomId;

  ListenToMessagesParams({required this.myUserId, required this.chatRoomId});
}

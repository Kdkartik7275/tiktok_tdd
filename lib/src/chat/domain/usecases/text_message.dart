// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tiktok_tdd/core/usecase/usecase.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/chat/domain/repository/chat_repository.dart';

class SendTextMessage implements UseCaseWithParams<void, SendMessagesParams> {
  final ChatRepository repository;

  SendTextMessage({required this.repository});
  @override
  ResultFuture<void> call(SendMessagesParams params) async =>
      await repository.sendTextMessage(
          roomId: params.roomId,
          myUserId: params.myUserId,
          message: params.message);
}

class SendMessagesParams {
  final String myUserId;
  final String roomId;
  final String message;

  SendMessagesParams({
    required this.myUserId,
    required this.roomId,
    required this.message,
  });
}

import 'dart:io';

import 'package:tiktok_tdd/core/common/enums/message_type.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';

abstract interface class ChatRepository {
  ResultFuture<ChatRoomEntity> createChatRoom(
      {required String userId, required String myUserId});

  ResultFuture<List<ChatRoomEntity>> fetchChatRooms({required String myUserId});
  Stream<List<MessageEntity>> listenToMessages(
      {required String chatRoomId, required String myUserId});

  ResultVoid sendTextMessage(
      {required String roomId,
      required String myUserId,
      required String message});

  ResultVoid sendFileMessage(
      {required MessagesType type,
      required String roomId,
      required File file,
      required String myUserId});
}

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';
import 'package:tiktok_tdd/core/common/errors/failure.dart';
import 'package:tiktok_tdd/core/network/connection_checker.dart';
import 'package:tiktok_tdd/core/utils/constants/typedefs.dart';
import 'package:tiktok_tdd/src/chat/data/data_source/chat_remote_data_source.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';
import 'package:tiktok_tdd/src/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  ChatRepositoryImpl(
      {required this.remoteDataSource, required this.connectionChecker});
  @override
  ResultFuture<ChatRoomEntity> createChatRoom(
      {required String userId, required String myUserId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final chatRoom = await remoteDataSource.createChatRoom(
          myUserId: myUserId, userId: userId);
      return right(chatRoom);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultFuture<List<ChatRoomEntity>> fetchChatRooms(
      {required String myUserId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }
      final chatRooms =
          await remoteDataSource.fetchChatRooms(myUserId: myUserId);
      return right(chatRooms);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<MessageEntity>> listenToMessages(
      {required String chatRoomId, required String myUserId}) {
    try {
      final messages = remoteDataSource.listenToMessages(
          chatRoomId: chatRoomId, myUserId: myUserId);
      return messages;
    } catch (e) {
      rethrow;
    }
  }

  @override
  ResultVoid sendTextMessage(
      {required String roomId,
      required String myUserId,
      required String message}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }

      await remoteDataSource.sendTextMessage(
          message: message, myUserId: myUserId, roomId: roomId);
      return right(null);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }

  @override
  ResultVoid sendFileMessage(
      {required MessagesType type,
      required String roomId,
      required File file,
      required String myUserId}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(FirebaseFailure(message: "No Internet Connection"));
      }

      await remoteDataSource.sendFileMessage(
          file: file, myUserId: myUserId, roomId: roomId, type: type);
      return right(null);
    } catch (e) {
      return left(FirebaseFailure(message: e.toString()));
    }
  }
}

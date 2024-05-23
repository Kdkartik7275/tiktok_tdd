import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/format_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/platform_exceptions.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';
import 'package:tiktok_tdd/src/chat/data/model/chat_room_model.dart';
import 'package:tiktok_tdd/src/chat/data/model/message_model.dart';
import 'package:uuid/uuid.dart';

abstract interface class ChatRemoteDataSource {
  Future<ChatRoomModel> createChatRoom(
      {required String userId, required String myUserId});
  Future<List<ChatRoomModel>> fetchChatRooms({required String myUserId});
  Stream<List<MessageModel>> listenToMessages(
      {required String chatRoomId, required String myUserId});
  Future<void> sendTextMessage(
      {required String roomId,
      required String myUserId,
      required String message});

  Future<void> sendFileMessage(
      {required MessagesType type,
      required String roomId,
      required File file,
      required String myUserId});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore _firestore;
  final TFunctions functions;
  final FirebaseStorage _storage;

  ChatRemoteDataSourceImpl(
      {required FirebaseFirestore firestore,
      required FirebaseStorage storage,
      required this.functions})
      : _firestore = firestore,
        _storage = storage;

  @override
  Future<ChatRoomModel> createChatRoom(
      {required String userId, required String myUserId}) async {
    try {
      ChatRoomModel chatRoomModel;
      String chatRoomId = functions.chatRoomId(myUserId, userId);

      var chatSnapshot =
          await _firestore.collection("chatRooms").doc(chatRoomId).get();

      if (chatSnapshot.exists) {
        chatRoomModel = ChatRoomModel.fromMap(chatSnapshot.data()!);
      } else {
        chatRoomModel = ChatRoomModel(
            roomId: chatRoomId,
            lastmessage: "",
            islastmsgread: false,
            userIds: [myUserId, userId],
            timeSent: DateTime.now());
        await _firestore
            .collection("chatRooms")
            .doc(chatRoomId)
            .set(chatRoomModel.toMap());
      }

      return chatRoomModel;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<List<ChatRoomModel>> fetchChatRooms({required String myUserId}) async {
    try {
      List<ChatRoomModel> chatRooms = [];
      var chatRoomSnapshots = await _firestore
          .collection("chatRooms")
          .where('userIds', arrayContains: myUserId)
          .get();
      for (var item in chatRoomSnapshots.docs) {
        final map = item.data();

        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(map);

        chatRooms.add(chatRoomModel);
      }
      return chatRooms;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Stream<List<MessageModel>> listenToMessages(
      {required String chatRoomId, required String myUserId}) {
    try {
      return _firestore
          .collection("chatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy('timeSent', descending: true)
          .snapshots()
          .asyncMap((event) async {
        List<MessageModel> messages = [];
        for (var message in event.docs) {
          MessageModel messageModel = MessageModel.fromMap(message.data());
          messages.add(messageModel);
        }
        return messages;
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<void> sendTextMessage(
      {required String roomId,
      required String myUserId,
      required String message}) async {
    try {
      String messageId = const Uuid().v1();
      MessageModel newMessage = MessageModel(
          senderId: myUserId,
          text: message,
          type: MessagesType.text,
          timeSent: DateTime.now(),
          messageId: messageId,
          isSeen: false);
      return _firestore
          .collection("chatRooms")
          .doc(roomId)
          .collection("messages")
          .doc(messageId)
          .set(newMessage.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<void> sendFileMessage(
      {required MessagesType type,
      required String roomId,
      required File file,
      required String myUserId}) async {
    try {
      String messageId = const Uuid().v1();
      String text =
          await _uploadFileToStorage(path: "$roomId/chat", file: file);
      MessageModel fileMessage = MessageModel(
          senderId: myUserId,
          text: text,
          type: type,
          timeSent: DateTime.now(),
          messageId: messageId,
          isSeen: false);
      _updateLastMessage(roomId: roomId, message: type.name);
      return _firestore
          .collection("chatRooms")
          .doc(roomId)
          .collection("messages")
          .doc(messageId)
          .set(fileMessage.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  _updateLastMessage({required String roomId, required String message}) async {
    try {
      return _firestore.collection("chatRooms").doc(roomId).update({
        'lastmessage': message,
      });
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Future<String> _uploadFileToStorage(String path, File file) async {
  //   final ref = _storage.ref().child('chats').child(path);
  //   await ref.putFile(File(file.path));
  //   String image = await ref.getDownloadURL();

  //   return image;
  // }

  Future<String> _uploadFileToStorage(
      {required String path, required File file}) async {
    try {
      final ref = _storage.ref().child('chats').child(path);
      UploadTask uploadTask = ref.putFile(File(file.path));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }
}

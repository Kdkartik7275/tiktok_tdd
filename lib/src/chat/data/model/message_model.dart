import 'dart:convert';

import 'package:tiktok_tdd/core/common/enums/message_type.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.senderId,
      required super.text,
      required super.type,
      required super.timeSent,
      required super.messageId,
      required super.isSeen});

  MessageModel copyWith({
    String? senderId,
    String? text,
    MessagesType? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      text: map['text'] as String,
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(senderid: $senderId,text: $text, type: $type, timesent: $timeSent, messageid: $messageId, isSeen: $isSeen)';
  }
}

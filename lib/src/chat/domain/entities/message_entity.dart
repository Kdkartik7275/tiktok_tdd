import 'package:equatable/equatable.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';

class MessageEntity extends Equatable {
  final String senderId;
  final String text;
  final MessagesType type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  const MessageEntity(
      {required this.senderId,
      required this.text,
      required this.type,
      required this.timeSent,
      required this.messageId,
      required this.isSeen});

  MessageEntity copyWith({
    String? senderId,
    String? text,
    MessagesType? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
  }) {
    return MessageEntity(
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  @override
  List<Object?> get props => [senderId, text, timeSent, messageId, isSeen];
}

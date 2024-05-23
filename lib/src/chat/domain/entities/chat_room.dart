// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  final String roomId;
  final String lastmessage;
  final bool islastmsgread;
  final DateTime timeSent;
  final List<String> userIds;

  const ChatRoomEntity({
    required this.roomId,
    required this.lastmessage,
    required this.islastmsgread,
    required this.timeSent,
    required this.userIds,
  });
  @override
  List<Object> get props {
    return [
      roomId,
      lastmessage,
      islastmsgread,
      timeSent,
    ];
  }

  ChatRoomEntity copyWith({
    String? roomId,
    List<String>? userIds,
    String? lastmessage,
    bool? islastmsgread,
    DateTime? timeSent,
  }) {
    return ChatRoomEntity(
      roomId: roomId ?? this.roomId,
      userIds: userIds ?? this.userIds,
      lastmessage: lastmessage ?? this.lastmessage,
      islastmsgread: islastmsgread ?? this.islastmsgread,
      timeSent: timeSent ?? this.timeSent,
    );
  }
}

import 'dart:convert';

import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';

class ChatRoomModel extends ChatRoomEntity {
  const ChatRoomModel(
      {required super.roomId,
      required super.userIds,
      required super.lastmessage,
      required super.islastmsgread,
      required super.timeSent});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'userIds': userIds,
      'lastmessage': lastmessage,
      'islastmsgread': islastmsgread,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  ChatRoomModel copyWith({
    String? roomId,
    List<String>? userIds,
    String? lastmessage,
    bool? islastmsgread,
    DateTime? timeSent,
  }) {
    return ChatRoomModel(
      roomId: roomId ?? this.roomId,
      userIds: userIds ?? this.userIds,
      lastmessage: lastmessage ?? this.lastmessage,
      islastmsgread: islastmsgread ?? this.islastmsgread,
      timeSent: timeSent ?? this.timeSent,
    );
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      roomId: map['roomId'] as String,
      lastmessage: map['lastmessage'] as String,
      islastmsgread: map['islastmsgread'] as bool,
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      userIds: List.from((map['userIds'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

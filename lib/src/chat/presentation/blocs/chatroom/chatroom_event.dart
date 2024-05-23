part of 'chatroom_bloc.dart';

sealed class ChatroomEvent extends Equatable {
  const ChatroomEvent();

  @override
  List<Object> get props => [];
}

final class OnChatRoomCreated extends ChatroomEvent {
  final String userId;
  final String myUserId;

  const OnChatRoomCreated({required this.userId, required this.myUserId});
}

final class OnFetchChatRooms extends ChatroomEvent {
  final String myUserId;

  const OnFetchChatRooms({required this.myUserId});
}

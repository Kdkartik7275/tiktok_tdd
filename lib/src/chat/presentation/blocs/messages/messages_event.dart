part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

final class OnListenToMessages extends MessagesEvent {
  final String chatRoomId;
  final String myUserId;

  const OnListenToMessages({required this.chatRoomId, required this.myUserId});
}

final class OnSendTextMessage extends MessagesEvent {
  final String myUserId;
  final String roomId;
  final String message;

  const OnSendTextMessage(
      {required this.myUserId, required this.roomId, required this.message});
}

final class OnSendFileMessage extends MessagesEvent {
  final String myUserId;
  final String roomId;

  final MessagesType type;

  const OnSendFileMessage(
      {required this.myUserId, required this.roomId, required this.type});
}

final class OnToggleMessageState extends MessagesEvent {
  final TextEditingController controller;

  const OnToggleMessageState({required this.controller});
}

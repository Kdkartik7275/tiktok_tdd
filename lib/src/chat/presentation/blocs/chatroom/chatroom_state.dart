part of 'chatroom_bloc.dart';

sealed class ChatroomState extends Equatable {
  const ChatroomState();

  @override
  List<Object> get props => [];
}

final class ChatroomInitial extends ChatroomState {}

final class ChatroomLoading extends ChatroomState {}

final class ChatroomFailure extends ChatroomState {
  final String error;

  const ChatroomFailure({required this.error});
}

final class ChatRoomCreated extends ChatroomState {
  final ChatRoomEntity chatRoom;

  const ChatRoomCreated({required this.chatRoom});
}

final class ChatRoomsLoaded extends ChatroomState {
  final List<ChatRoomEntity> chatRooms;

  const ChatRoomsLoaded({required this.chatRooms});
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/create_chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/fetch_chatrroms.dart';

part 'chatroom_event.dart';
part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  final CreateChatRoom createChatRoom;
  final FetchChatRooms fetchChatRooms;
  ChatroomBloc({
    required this.createChatRoom,
    required this.fetchChatRooms,
  }) : super(ChatroomInitial()) {
    on<OnChatRoomCreated>(_createChatRoom);
    on<OnFetchChatRooms>(_fetchChatRooms);
  }

  FutureOr<void> _createChatRoom(
      OnChatRoomCreated event, Emitter<ChatroomState> emit) async {
    emit(ChatroomLoading());
    final room = await createChatRoom.call(
        CreateChatRoomParams(userId: event.userId, myUserId: event.myUserId));
    room.fold((l) => ChatroomFailure(error: l.message),
        (r) => emit(ChatRoomCreated(chatRoom: r)));
  }

  FutureOr<void> _fetchChatRooms(
      OnFetchChatRooms event, Emitter<ChatroomState> emit) async {
    emit(ChatroomLoading());
    final rooms = await fetchChatRooms.call(event.myUserId);
    rooms.fold((l) => emit(ChatroomFailure(error: l.message)),
        (r) => emit(ChatRoomsLoaded(chatRooms: r)));
  }

  @override
  void onChange(Change<ChatroomState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}

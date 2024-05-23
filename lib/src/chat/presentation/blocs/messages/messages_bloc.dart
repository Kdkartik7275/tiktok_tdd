import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/file_message.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/listen_messages.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/text_message.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  List<MessageEntity> messages = [];
  final ListenToMessages listenToMessages;
  final SendTextMessage sendTextMessage;
  final SendFileMessage fileMessage;
  final TFunctions functions;
  MessagesBloc(
      {required this.listenToMessages,
      required this.sendTextMessage,
      required this.functions,
      required this.fileMessage})
      : super(MessagesInitial()) {
    on<OnListenToMessages>(_listenMessages);
    on<OnSendTextMessage>(_sendTextMessage);
    on<OnSendFileMessage>(_sendFileMessage);
    on<OnToggleMessageState>(toggleMessageState);
  }

  _listenMessages(OnListenToMessages event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());

    await emit.forEach(
        listenToMessages.call(ListenToMessagesParams(
            myUserId: event.myUserId,
            chatRoomId: event.chatRoomId)), onData: (data) {
      messages = data;

      return MessagesLoaded(messages: data);
    }).catchError((error) {
      emit(MessagesFailure(error: error.toString()));
    });
  }

  @override
  void onChange(Change<MessagesState> change) {
    super.onChange(change);
    print(change);
  }

  FutureOr<void> _sendTextMessage(
      OnSendTextMessage event, Emitter<MessagesState> emit) async {
    emit(MessagesLoading());

    final message = await sendTextMessage.call(SendMessagesParams(
        myUserId: event.myUserId,
        roomId: event.roomId,
        message: event.message));

    message.fold((l) => emit(MessagesFailure(error: l.message)),
        (r) => emit(SendMessage()));
  }

  toggleMessageState(OnToggleMessageState event, Emitter<MessagesState> emit) {
    emit(IsRecording());
    if (event.controller.text.isNotEmpty) {
      emit(IsMessage());
    } else {
      emit(IsRecording());
    }
  }

  FutureOr<void> _sendFileMessage(
      OnSendFileMessage event, Emitter<MessagesState> emit) async {
    XFile? file;
    emit(MessagesLoading());
    if (event.type == MessagesType.image) {
      file = await functions.getImage(ImageSource.camera);
    }
    if (event.type == MessagesType.video) {
      file = await functions.getVideo(ImageSource.gallery);
    }
    if (file != null) {
      emit(SendingMessage(file: File(file.path), type: event.type));
      final uploading = await fileMessage.call(SendFileMessageParams(
          myUserId: event.myUserId,
          type: event.type,
          file: File(file.path),
          roomId: event.roomId));

      uploading.fold((l) => emit(MessagesFailure(error: l.message)),
          (r) => emit(SendMessage()));
    }
  }
}

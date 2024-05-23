part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

final class MessagesLoading extends MessagesState {}

final class MessagesActionState extends MessagesState {}

final class MessagesLoadingAction extends MessagesActionState {}

final class IsMessage extends MessagesActionState {}

final class IsRecording extends MessagesActionState {}

final class MessagesLoaded extends MessagesState {
  final List<MessageEntity> messages;

  const MessagesLoaded({required this.messages});
}

final class MessagesFailure extends MessagesState {
  final String error;

  const MessagesFailure({required this.error});
}

final class SendMessage extends MessagesState {}

final class SendingMessage extends MessagesState {
  final File file;
  final MessagesType type;

  const SendingMessage({required this.file, required this.type});
}

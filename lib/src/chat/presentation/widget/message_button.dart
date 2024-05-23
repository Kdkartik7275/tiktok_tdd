import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/circular_container.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/messages/messages_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/pages/chat_screen.dart';

class MessageSendButton extends StatelessWidget {
  const MessageSendButton({
    super.key,
    required this.myUser,
    required this.widget,
    required this.message,
  });

  final AppUserLoaded myUser;
  final ChatScreen widget;
  final TextEditingController message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesBloc, MessagesState>(
      buildWhen: (previous, current) => current is MessagesActionState,
      builder: (context, state) {
        if (state is MessagesActionState) {
          return IconButton(
              onPressed: () {
                if (state is IsMessage) {
                  context.read<MessagesBloc>().add(OnSendTextMessage(
                      myUserId: myUser.user.uid,
                      roomId: widget.chatRoom.roomId,
                      message: message.text));
                  message.clear();
                }
                if (state is IsRecording) {
                  TSnackBar.showSuccessSnackBar(
                      context: context, message: "Start Recording");
                }
              },
              icon: TCircularContainer(
                backgroundColor: TColors.lightBlue,
                height: 60,
                width: 60,
                child: Icon(
                  state is IsRecording
                      ? Icons.keyboard_voice
                      : Icons.send_sharp,
                  color: TColors.white,
                ),
              ));
        }
        return TCircularContainer(
          backgroundColor: TColors.lightBlue,
          height: 60,
          width: 60,
          child: const Icon(
            Icons.keyboard_voice,
            color: TColors.white,
          ),
        );
      },
    );
  }
}

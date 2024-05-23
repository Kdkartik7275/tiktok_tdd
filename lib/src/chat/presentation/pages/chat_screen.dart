import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';

import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/message_loader.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/init_dependencies.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';
import 'package:tiktok_tdd/src/chat/domain/usecases/listen_messages.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/messages/messages_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/widget/message_button.dart';
import 'package:tiktok_tdd/src/chat/presentation/widget/message_tile.dart';
import 'package:tiktok_tdd/src/profile/presentation/pages/user_profile.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoomEntity chatRoom;
  final UserEntity user;
  const ChatScreen({
    Key? key,
    required this.chatRoom,
    required this.user,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final message = TextEditingController();
  List<MessageEntity> messages = [];
  bool isEmojiContainer = false;
  FocusNode focus = FocusNode();
  hideEmojiContainer() {
    setState(() {
      isEmojiContainer = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      isEmojiContainer = true;
    });
  }

  void showKeyboard() => focus.requestFocus();
  void hideKeyboard() => focus.unfocus();

  toggleEmojiKeyboard() {
    if (isEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _showAttachmentOptions(
      {required String myUserId,
      required String roomId,
      required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Send Image'),
              onTap: () {
                context.read<MessagesBloc>().add(OnSendFileMessage(
                    myUserId: myUserId,
                    roomId: roomId,
                    type: MessagesType.image));
              },
            ),
            ListTile(
              leading: const Icon(Icons.gif),
              title: const Text('Send GIF'),
              onTap: () {
                // Implement action to send GIF
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_collection),
              title: const Text('Send Video'),
              onTap: () async {
                // final video = await TFunctions().getVideo(ImageSource.camera);
                // if (video != null) {
                //   print(video.path);
                // }
                context.read<MessagesBloc>().add(OnSendFileMessage(
                    myUserId: myUserId,
                    roomId: roomId,
                    type: MessagesType.video));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myUser =
        BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: TAppBar(
          showBackArrow: true,
          title: Text(widget.user.username),
          actions: [
            GestureDetector(
              onTap: () => TNavigators.navigatePush(
                  context,
                  ProfileScreen(
                    uid: widget.user.uid,
                    showBackArrow: true,
                  )),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.user.profilePic),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            BlocConsumer<MessagesBloc, MessagesState>(
                listener: (context, state) {
              if (state is MessagesFailure) {
                TSnackBar.showErrorSnackBar(
                    context: context, message: state.error);
              }
              if (state is SendingMessage) {
                TNavigators.navigatePop(context);
              }
            }, builder: (context, state) {
              if (state is SendingMessage) {
                return Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: TColors.background,
                    gradient: LinearGradient(colors: [
                      TColors.lightBlue,
                      TColors.lightRed,
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TRoundedContainer(
                        child: state.type == MessagesType.image
                            ? Image(image: FileImage(state.file))
                            : null,
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Text(
                        "Sending ${state.type.name}",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(color: TColors.white),
                      )
                    ],
                  ),
                );
              }

              return const SizedBox();
            }),
            Expanded(
                child: StreamBuilder<List<MessageEntity>>(
                    stream: sl<ListenToMessages>().call(ListenToMessagesParams(
                        chatRoomId: widget.chatRoom.roomId,
                        myUserId: myUser.user.uid)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          messages.isEmpty) {
                        return const MessageLoader();
                      }
                      if (snapshot.hasData) {
                        messages = snapshot.data!;
                        return ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              return MessageTile(
                                message: message,
                                userProfile: widget.user.profilePic,
                              );
                            });
                      }
                      return const Center(
                        child: Text("Start Conersations...."),
                      );
                    })),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          TSizes.md, TSizes.sm, 0, TSizes.sm),
                      child: TextFormField(
                        controller: message,
                        onChanged: (value) => context
                            .read<MessagesBloc>()
                            .add(OnToggleMessageState(controller: message)),
                        decoration: const InputDecoration(
                            hintText: "Send a message...",
                            contentPadding: EdgeInsets.only(
                                top: TSizes.xs, left: TSizes.md)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _showAttachmentOptions(
                            myUserId: myUser.user.uid,
                            roomId: widget.chatRoom.roomId,
                            context: context);
                      },
                      icon: const Icon(
                        Icons.attach_file_outlined,
                        color: Colors.white,
                      )),
                  MessageSendButton(
                      myUser: myUser, widget: widget, message: message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

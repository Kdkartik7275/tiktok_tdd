import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/chats_loader.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/chatroom/chatroom_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/widget/chat_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late UserEntity myUser;
  @override
  void initState() {
    super.initState();
    myUser =
        (BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded).user;
    context.read<ChatroomBloc>().add(OnFetchChatRooms(myUserId: myUser.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text("Direct Messages"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: BlocConsumer<ChatroomBloc, ChatroomState>(
          builder: (context, state) {
            if (state is ChatroomFailure) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is ChatRoomsLoaded) {
              final users = state.chatRooms;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final room = users[index];
                    String userId = room.roomId.replaceAll(myUser.uid, "");
                    return ChatTile(
                      chatRoom: room,
                      userId: userId,
                    );
                  });
            } else {
              return const ChatsLoader();
            }
          },
          listener: (context, state) {}),
    );
  }
}

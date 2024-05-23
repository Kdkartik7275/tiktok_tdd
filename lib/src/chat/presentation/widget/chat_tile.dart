// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:tiktok_tdd/core/common/cubits/single_user/single_user_cubit.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/chat_room.dart';
import 'package:tiktok_tdd/src/chat/presentation/pages/chat_screen.dart';

class ChatTile extends StatefulWidget {
  final ChatRoomEntity chatRoom;
  final String userId;
  const ChatTile({
    Key? key,
    required this.chatRoom,
    required this.userId,
  }) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  void initState() {
    super.initState();
    context.read<SingleUserCubit>().getUserData(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleUserCubit, SingleUserState>(
      builder: (context, state) {
        if (state is SingleUserLoaded) {
          final user = state.user;
          return ListTile(
            onTap: () => TNavigators.navigatePush(
                context,
                ChatScreen(
                  chatRoom: widget.chatRoom,
                  user: user,
                )),
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(user.profilePic),
            ),
            title: Text(
              user.username,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              widget.chatRoom.lastmessage,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: Text(
              DateFormat.Hm().format(widget.chatRoom.timeSent).toString(),
            ),
          );
        }
        return const ListTile(
          leading: TShimmerEffect(
            radius: TSizes.borderRadiusXl,
            height: 60,
            width: 60,
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TShimmerEffect(
              height: 30,
              width: 250,
              radius: TSizes.sm,
            ),
          ),
          subtitle: TShimmerEffect(
            height: 30,
            width: 250,
            radius: TSizes.sm,
          ),
          trailing: TShimmerEffect(
            height: 30,
            width: 70,
            radius: TSizes.sm,
          ),
        );
      },
    );
  }
}

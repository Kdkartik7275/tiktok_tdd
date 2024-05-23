// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/enums/message_type.dart';

import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/common/widgets/effects/shimmer_effect.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/chat/domain/entities/message_entity.dart';
import 'package:tiktok_tdd/src/chat/presentation/widget/video_message.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;
  final String userProfile;
  const MessageTile({
    Key? key,
    required this.message,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser =
        BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    return Padding(
      padding: const EdgeInsets.only(bottom: TSizes.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: message.senderId == myUser.user.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          message.senderId == myUser.user.uid
              ? const SizedBox()
              : CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade400,
                  //  backgroundImage: NetworkImage(userProfile),
                ),
          const SizedBox(width: TSizes.sm),
          message.type == MessagesType.video
              ? MessageVideo(videoUrl: message.text)
              : message.type == MessagesType.image
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(TSizes.sm),
                      child: CachedNetworkImage(
                        imageUrl: message.text,
                        filterQuality: FilterQuality.high,
                        height: 250,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const TShimmerEffect(
                          height: 200,
                          width: 200,
                          radius: 20,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : TRoundedContainer(
                      backgroundColor: message.senderId == myUser.user.uid
                          ? TColors.background
                          : Colors.white,
                      showBorder:
                          message.senderId == myUser.user.uid ? true : false,
                      padding:
                          const EdgeInsets.symmetric(horizontal: TSizes.md),
                      height: 40,
                      child: Center(
                        child: Text(
                          message.text,
                          style: Theme.of(context).textTheme.titleSmall!.apply(
                              color: message.senderId == myUser.user.uid
                                  ? Colors.white
                                  : TColors.background),
                        ),
                      ),
                    ),
          const SizedBox(width: TSizes.sm),
          message.senderId == myUser.user.uid
              ? CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: NetworkImage(myUser.user.profilePic),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

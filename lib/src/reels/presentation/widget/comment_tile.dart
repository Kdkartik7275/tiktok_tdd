// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/cubits/single_user/single_user_cubit.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/single_comment_loader.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/profile/presentation/widgets/profile_image.dart';

import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';

class CommentTile extends StatelessWidget {
  final CommentEntity comment;
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    context.read<SingleUserCubit>().getUserData(userId: comment.userid);

    return BlocBuilder<SingleUserCubit, SingleUserState>(
      builder: (context, state) {
        if (state is SingleUserLoaded) {
          final commentUser = state.user;
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProfileImage(
                    profileURL: commentUser.profilePic, height: 30, width: 30),
                const SizedBox(width: TSizes.sm),
                Text(
                  commentUser.username,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      comment.comment,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    TFunctions()
                        .getTimeAgo(DateTime.parse(comment.commentdate))
                        .toString(),
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    comment.likes.contains(user.user.uid)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: comment.likes.contains(user.user.uid)
                        ? Colors.red
                        : Colors.white,
                    size: 20,
                  ),
                ),
                Text(
                  comment.likes.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }
        return const SingleCommentLoader();
      },
    );
  }
}

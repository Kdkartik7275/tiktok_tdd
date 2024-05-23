// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/comments_loader.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/comments/comments_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/widget/comment_tile.dart';

class CommentScreen extends StatefulWidget {
  final String videoId;

  const CommentScreen({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final comment = TextEditingController();

  List<CommentEntity> comments = [];

  @override
  void initState() {
    super.initState();
    context.read<CommentsBloc>().add(OnFetchComments(videoId: widget.videoId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<CommentsBloc>()
        .add(OnCommentsScreenReturned(videoId: widget.videoId));
  }

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    return Scaffold(
      appBar: const TAppBar(
        title: Text("Comments"),
        centreTitle: true,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocConsumer<CommentsBloc, CommentsState>(
            listener: (context, state) {},
            buildWhen: (previous, current) => current is! AddCommentLoading,
            builder: (context, state) {
              if (state is CommentsFailure) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is CommentsLoaded) {
                comments = state.comments;
                return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return CommentTile(comment: comment);
                    });
              } else if (state is CommentsLoading && comments.isEmpty) {
                return const CommentsLoader();
              }
              return const SizedBox();
            },
          )),
          TRoundedContainer(
            height: 60,
            backgroundColor: TColors.background,
            radius: 0,
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: comment,
                  decoration: const InputDecoration(
                      hintText: "Add your comment..",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: TSizes.spaceBtwInputFields)),
                )),
                TextButton(
                    onPressed: () {
                      if (comment.text.isNotEmpty) {
                        context.read<CommentsBloc>().add(OnAddComment(
                            comment: comment.text,
                            videoId: widget.videoId,
                            userid: user.user.uid));
                        comment.clear();
                      }
                    },
                    child: Text(
                      "Send",
                      style: TextStyle(color: TColors.lightRed, fontSize: 16),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

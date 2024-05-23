import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/single_comment_loader.dart';

class CommentsLoader extends StatelessWidget {
  const CommentsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return const SingleCommentLoader();
        },
        separatorBuilder: (_, index) {
          return const SizedBox(
            height: 15,
          );
        },
      ),
    );
  }
}

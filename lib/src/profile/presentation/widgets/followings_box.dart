import 'package:flutter/material.dart';

class FollowingsBox extends StatelessWidget {
  final int followers;
  final int followings;
  final int likes;
  const FollowingsBox({
    super.key,
    required this.followers,
    required this.followings,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          child: Column(
            children: [
              Text(
                followings.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Followings",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text(
                followers.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Followers",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              likes.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              "Likes",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}

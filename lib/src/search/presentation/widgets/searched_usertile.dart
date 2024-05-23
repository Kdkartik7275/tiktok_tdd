import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/presentation/pages/user_profile.dart';

class SearchedUserTile extends StatelessWidget {
  final UserEntity user;
  const SearchedUserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => TNavigators.navigatePush(
          context,
          ProfileScreen(
            uid: user.uid,
            showBackArrow: true,
          )),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        backgroundImage: NetworkImage(user.profilePic),
      ),
      title: Text(
        user.username,
        style: const TextStyle(color: Colors.white),
      ),
      //
    );
  }
}

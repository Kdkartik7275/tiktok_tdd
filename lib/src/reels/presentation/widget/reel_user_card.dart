// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_tdd/core/common/cubits/reel_user/reel_user_cubit.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';

import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/profile/presentation/widgets/profile_image.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';

class ReelUserCard extends StatefulWidget {
  const ReelUserCard({
    Key? key,
    required this.reelUser,
    required this.reel,
    required this.myUserId,
  }) : super(key: key);

  final UserEntity reelUser;
  final ReelEntity reel;
  final String myUserId;

  @override
  State<ReelUserCard> createState() => _ReelUserCardState();
}

class _ReelUserCardState extends State<ReelUserCard> {
  bool isExpanded = false;

  bool isFollow = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  isFollowed() {
    if (widget.reelUser.followers.contains(widget.myUserId)) {
      setState(() {
        isFollow = true;
      });
    } else {
      setState(() {
        isFollow = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isFollowed();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.3,
        margin: const EdgeInsets.only(bottom: TSizes.sm, left: TSizes.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProfileImage(
                  profileURL: widget.reelUser.profilePic,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: TSizes.sm),
                Text(
                  "@ ${widget.reelUser.username}",
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(width: TSizes.sm),
                GestureDetector(
                  onTap: () {
                    context.read<ReelUserCubit>().follow(
                        userId: widget.reelUser.uid, myUserId: widget.myUserId);
                    setState(() {
                      isFollow = !isFollow;
                    });
                  },
                  child: TRoundedContainer(
                    height: 30,
                    width: 100,
                    radius: TSizes.sm,
                    backgroundColor:
                        isFollow ? Colors.transparent : TColors.lightBlue,
                    showBorder: isFollow ? true : false,
                    child: Center(
                      child: Text(
                        isFollow ? "Following" : "Follow",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            GestureDetector(
              onTap: toggleExpanded,
              child: Text(
                isExpanded
                    ? "${TFunctions().extractCaption(widget.reel.caption)} "
                        " \n ${TFunctions().extractHashtags(widget.reel.caption)} "
                    : widget.reel.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: isExpanded ? null : 2,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.music,
                  color: TColors.white,
                  size: 15,
                ),
                const SizedBox(width: TSizes.sm),
                widget.reel.songname == ""
                    ? Text(
                        "${widget.reelUser.username} ---- Original Audio",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!,
                      )
                    : Text(
                        " ${widget.reel.songname} ---- ${widget.reelUser.username}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

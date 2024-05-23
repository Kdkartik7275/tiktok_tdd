import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_tdd/core/common/cubits/reel_user/reel_user_cubit.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/reels/reels_bloc.dart';
import 'package:tiktok_tdd/src/reels/presentation/pages/comments_screen.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/loading_user_card.dart';
import 'package:tiktok_tdd/src/reels/presentation/widget/reel_user_card.dart';
import 'package:video_player/video_player.dart';

class ReelWidget extends StatefulWidget {
  final ReelEntity reel;

  const ReelWidget({super.key, required, required this.reel});

  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    setState(() {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.reel.videoUrl));
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(100);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myUser =
        BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    context.read<ReelUserCubit>().getUserData(userId: widget.reel.uid);
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GestureDetector(
            // onTap: () => videoPlayerController.pause(),
            child: VideoPlayer(
              videoPlayerController,
            ),
          ),
        ),
        BlocBuilder<ReelUserCubit, ReelUserState>(builder: (context, state) {
          if (state is ReelUserLoaded) {
            final reelUser = state.user;
            return ReelUserCard(
                reelUser: reelUser,
                reel: widget.reel,
                myUserId: myUser.user.uid);
          }
          return const Positioned(bottom: 0, child: LoadingUserCard());
        }),
        Positioned(
          top: 0,
          right: 5,
          child: SizedBox(
            width: 100,
            height: MediaQuery.of(context).size.height / 1.27,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<ReelsBloc>().add(OnReelLikeEvent(
                            videoId: widget.reel.videoId,
                            userId: myUser.user.uid));
                      },
                      icon: widget.reel.likes.contains(myUser.user.uid)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 30,
                            ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${widget.reel.likes.length}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                Column(
                  children: [
                    IconButton(
                      onPressed: () => TNavigators.navigatePush(
                          context, CommentScreen(videoId: widget.reel.videoId)),
                      icon: const Icon(
                        FontAwesomeIcons.comment,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      widget.reel.commentsCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.share,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      widget.reel.shareCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 15, right: 12),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35), color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                "assets/images/music.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}

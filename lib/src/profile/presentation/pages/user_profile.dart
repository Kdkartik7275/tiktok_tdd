// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiktok_tdd/core/common/cubits/single_user/single_user_cubit.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/tabbar.dart';
import 'package:tiktok_tdd/core/common/widgets/containers/rounded_container.dart';
import 'package:tiktok_tdd/core/common/widgets/loaders/profile_loader.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/app/presentation/pages/onboarding.dart';
import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';
import 'package:tiktok_tdd/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:tiktok_tdd/src/chat/presentation/blocs/chatroom/chatroom_bloc.dart';
import 'package:tiktok_tdd/src/profile/presentation/widgets/followings_box.dart';
import 'package:tiktok_tdd/src/profile/presentation/widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  final String? uid;
  final bool showBackArrow;
  const ProfileScreen({
    Key? key,
    this.uid,
    this.showBackArrow = false,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> followers = [];
  List<String> followings = [];
  bool isFollow = false;

  followUser({required String userId, required String myUserId}) {
    context.read<SingleUserCubit>().follow(userId: userId, myUserId: myUserId);
    if (isFollow) {
      setState(() {
        followers.remove(myUserId);
        isFollow = false;
      });
    } else {
      setState(() {
        followers.add(myUserId);

        isFollow = true;
      });
    }
  }

  getFollowedData(UserEntity user, String currentUserId) {
    followers = user.followers;
    followings = user.followings;
    isFollow = user.followers.contains(currentUserId) ? true : false;
  }

  @override
  void initState() {
    super.initState();
    final currentUser =
        BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    context
        .read<SingleUserCubit>()
        .getUserData(userId: widget.uid ?? currentUser.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final myUser =
        BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;

    return BlocBuilder<SingleUserCubit, SingleUserState>(
      builder: (context, state) {
        if (state is SingleUserLoaded) {
          final user = state.user;
          getFollowedData(user, myUser.user.uid);

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: TAppBar(
                showBackArrow: widget.showBackArrow,
                title: Text(" ${user.username}"),
                actions: user.uid == myUser.user.uid
                    ? [
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is UnAuthenticated) {
                              return TNavigators.offALL(
                                  context, const OnBoardingPage());
                            }
                          },
                          child: IconButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(OnUserLogout());
                              },
                              icon: const Icon(Icons.logout)),
                        )
                      ]
                    : null,
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      ProfileImage(
                        height: 80,
                        width: 80,
                        profileURL: user.profilePic,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      Text(
                        "@ ${user.username}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      FollowingsBox(
                          followers: followers.length,
                          followings: followings.length,
                          likes: user.likesCount),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      if (user.uid == myUser.user.uid)
                        GestureDetector(
                          onTap: () {},
                          child: TRoundedContainer(
                            height: 45,
                            width: 150,
                            radius: 0,
                            backgroundColor: TColors.lightRed,
                            child: Center(
                                child: Text(
                              "Edit Profile",
                              style: Theme.of(context).textTheme.titleLarge,
                            )),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                followUser(
                                    userId: user.uid,
                                    myUserId: myUser.user.uid);
                              },
                              child: TRoundedContainer(
                                height: 45,
                                width: 150,
                                radius: TSizes.xs,
                                backgroundColor: isFollow
                                    ? TColors.background
                                    : TColors.lightBlue,
                                showBorder: isFollow ? true : false,
                                child: Center(
                                  child: Text(
                                    isFollow ? "Following" : "Follow",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(letterSpacingDelta: 0.5),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),
                            BlocListener<ChatroomBloc, ChatroomState>(
                              listener: (context, state) {
                                if (state is ChatroomFailure) {
                                  return TSnackBar.showErrorSnackBar(
                                      context: context, message: state.error);
                                } else if (state is ChatRoomCreated) {
                                  return TSnackBar.showSuccessSnackBar(
                                      context: context,
                                      message: "ChatRoomCreated");
                                }
                              },
                              child: GestureDetector(
                                onTap: () => context.read<ChatroomBloc>().add(
                                    OnChatRoomCreated(
                                        userId: user.uid,
                                        myUserId: myUser.user.uid)),
                                child: TRoundedContainer(
                                  height: 45,
                                  width: 150,
                                  radius: TSizes.xs,
                                  backgroundColor: TColors.lightRed,
                                  child: Center(
                                    child: Text(
                                      "Message",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .apply(letterSpacingDelta: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      TTabBar(
                        labelColor: TColors.lightBlue,
                        indicatorColor: TColors.lightBlue,
                        tabs: const [
                          Tab(
                            child: Icon(Icons.grid_view),
                          ),
                          Tab(
                            child: Icon(Icons.favorite_border),
                          ),
                        ],
                      ),
                      const Expanded(
                          child: TabBarView(
                        children: [
                          Center(
                            child: Text("Reels"),
                          ),
                          Center(
                            child: Text("Likes"),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const ProfileLoader();
      },
    );
  }
}

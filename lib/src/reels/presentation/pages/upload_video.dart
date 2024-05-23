// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_tdd/core/common/widgets/appbar/appbar.dart';
import 'package:tiktok_tdd/core/utils/constants/colors.dart';
import 'package:tiktok_tdd/core/utils/constants/sizes.dart';
import 'package:tiktok_tdd/core/utils/navigator/navigators.dart';
import 'package:tiktok_tdd/core/utils/popups/dialogs.dart';
import 'package:tiktok_tdd/core/utils/popups/snackbars.dart';
import 'package:tiktok_tdd/navaigation_menu.dart';
import 'package:tiktok_tdd/src/app/presentation/cubit/current_user/app_user_cubit.dart';
import 'package:tiktok_tdd/src/reels/presentation/bloc/upload/upload_reel_bloc.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class UploadVideoScreen extends StatefulWidget {
  final File video;
  final String videoPath;
  const UploadVideoScreen({
    Key? key,
    required this.video,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  late VideoPlayerController videoPlayerController;
  final TextEditingController songController = TextEditingController();
  final TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.video);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    songController.dispose();
    captionController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AppUserCubit>(context).state as AppUserLoaded;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        actions: [
          TextButton(
            onPressed: () {
              if (captionController.text.isEmpty) {
                return TSnackBar.showErrorSnackBar(
                    context: context, message: "Add Caption");
              }
              context.read<UploadReelBloc>().add(OnUploadReel(
                  userId: user.user.uid,
                  videoPath: widget.videoPath,
                  caption: captionController.text,
                  songName: songController.text));
            },
            child: Text(
              "Upload",
              style: TextStyle(color: TColors.lightBlue),
            ),
          ),
        ],
      ),
      body: BlocConsumer<UploadReelBloc, UploadReelState>(
        listener: (context, state) {
          if (state is UploadReelFailure) {
            TDialogs.stopDialog(context);
            TSnackBar.showErrorSnackBar(context: context, message: state.error);
          }
          if (state is UploadReelSuccess) {
            TDialogs.stopDialog(context);
            TNavigators.offALL(context, const NavigationMenu());
          }
          if (state is UploadReelLoading) {
            TDialogs.showLoadingDialog(context, "Uploading Please wait");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: VideoPlayer(videoPlayerController),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.sm),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: songController,
                        decoration: const InputDecoration(
                          hintText: "Song Name",
                          prefixIcon: Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TextFormField(
                        controller: captionController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: "Add Caption",
                          prefixIcon: Icon(
                            Icons.closed_caption,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

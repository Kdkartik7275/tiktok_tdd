import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class MessageVideo extends StatefulWidget {
  final String videoUrl;
  const MessageVideo({
    super.key,
    required this.videoUrl,
  });

  @override
  State<MessageVideo> createState() => _MessageVideoState();
}

class _MessageVideoState extends State<MessageVideo> {
  bool isVideoPlaying = false;
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();

    setState(() {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  togglePlayButton() {
    setState(() {
      isVideoPlaying = !isVideoPlaying;
    });
    if (isVideoPlaying) {
      videoPlayerController.play();
    } else {
      videoPlayerController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: 200,
            child: VideoPlayer(videoPlayerController),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => togglePlayButton(),
              child: Icon(
                isVideoPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:equatable/equatable.dart';

class ReelEntity extends Equatable {
  final String uid;
  final String videoUrl;
  final String videoId;
  final String thumbnail;
  final String songname;
  final String caption;
  final List likes;
  final int shareCount;
  final int commentsCount;

  const ReelEntity(
      {required this.uid,
      required this.videoUrl,
      required this.videoId,
      required this.thumbnail,
      required this.songname,
      required this.caption,
      required this.likes,
      required this.shareCount,
      required this.commentsCount});

  @override
  List<Object> get props {
    return [
      uid,
      videoUrl,
      videoId,
      thumbnail,
      songname,
      caption,
      likes,
      shareCount,
      commentsCount,
    ];
  }
}

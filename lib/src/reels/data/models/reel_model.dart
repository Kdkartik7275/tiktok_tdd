import 'dart:convert';

import 'package:tiktok_tdd/src/reels/domain/enitites/reel_entity.dart';

class ReelModel extends ReelEntity {
  const ReelModel(
      {required super.uid,
      required super.videoUrl,
      required super.videoId,
      required super.thumbnail,
      required super.songname,
      required super.caption,
      required super.likes,
      required super.shareCount,
      required super.commentsCount});

  ReelEntity copyWith({
    String? uid,
    String? videoUrl,
    String? videoId,
    String? thumbnail,
    String? songname,
    String? caption,
    List? likes,
    int? shareCount,
    int? commentsCount,
  }) {
    return ReelEntity(
      uid: uid ?? this.uid,
      videoUrl: videoUrl ?? this.videoUrl,
      videoId: videoId ?? this.videoId,
      thumbnail: thumbnail ?? this.thumbnail,
      songname: songname ?? this.songname,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      shareCount: shareCount ?? this.shareCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'videoUrl': videoUrl,
      'videoId': videoId,
      'thumbnail': thumbnail,
      'songname': songname,
      'caption': caption,
      'likes': likes,
      'shareCount': shareCount,
      'commentsCount': commentsCount,
    };
  }

  factory ReelModel.fromMap(Map<String, dynamic> map) {
    return ReelModel(
      uid: map['uid'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      videoId: map['videoId'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      songname: map['songname'] ?? '',
      caption: map['caption'] ?? '',
      likes: List.from((map['likes'] ?? [])),
      shareCount: map['shareCount'] ?? 0,
      commentsCount: map['commentsCount'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelModel.fromJson(String source) =>
      ReelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

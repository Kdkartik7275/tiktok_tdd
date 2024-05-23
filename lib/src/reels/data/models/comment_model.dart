import 'dart:convert';

import 'package:tiktok_tdd/src/reels/domain/enitites/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.comment,
      required super.commentdate,
      required super.likes,
      required super.userid,
      required super.commentid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'commentdate': commentdate,
      'likes': likes,
      'userid': userid,
      'commentid': commentid,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] ?? '',
      commentdate: map['commentdate'] ?? '',
      likes: List.from((map['likes'] ?? [])),
      userid: map['userid'] ?? '',
      commentid: map['commentid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String comment;
  final String commentdate;

  final List likes;
  final String userid;
  final String commentid;

  const CommentEntity(
      {required this.comment,
      required this.commentdate,
      required this.likes,
      required this.userid,
      required this.commentid});

  @override
  List<Object?> get props => [
        comment,
        commentdate,
        commentid,
        likes,
        userid,
      ];
}

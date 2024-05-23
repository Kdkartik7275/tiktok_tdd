// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String username;
  final String email;
  final String uid;
  final String bio;
  final String profilePic;
  final bool isActive;
  final List<String> followers;
  final List<String> followings;
  final int likesCount;

  const UserEntity(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.profilePic,
      required this.isActive,
      required this.followers,
      required this.followings,
      required this.likesCount});

  @override
  List<Object?> get props => [];
}

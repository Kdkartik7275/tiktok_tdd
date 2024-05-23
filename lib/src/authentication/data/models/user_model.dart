import 'package:tiktok_tdd/src/authentication/domain/enities/user.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.username,
      required super.email,
      required super.uid,
      required super.bio,
      required super.profilePic,
      required super.followers,
      required super.followings,
      required super.isActive,
      required super.likesCount});

  UserModel copyWith(
      {String? username,
      String? email,
      String? uid,
      String? bio,
      String? profilePic,
      List<String>? followers,
      List<String>? followings,
      bool? isActive,
      int? likesCount}) {
    return UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        bio: bio ?? this.bio,
        profilePic: profilePic ?? this.profilePic,
        followers: followers ?? this.followers,
        followings: followings ?? this.followings,
        isActive: isActive ?? this.isActive,
        likesCount: likesCount ?? this.likesCount);
  }

  static UserModel empty() => const UserModel(
      username: "",
      email: "",
      uid: "",
      bio: "",
      profilePic: "",
      followers: [],
      followings: [],
      isActive: false,
      likesCount: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'uid': uid,
      'bio': bio,
      'profilePic': profilePic,
      'followers': followers,
      'followings': followings,
      'isActive': isActive,
      'likesCount': likesCount
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      bio: map['bio'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isActive: map['isActive'] ?? false,
      followers: List<String>.from((map['followers'] ?? [])),
      followings: List<String>.from((map['followings'] ?? [])),
      likesCount: map['likesCount'] ?? 0,
    );
  }
}

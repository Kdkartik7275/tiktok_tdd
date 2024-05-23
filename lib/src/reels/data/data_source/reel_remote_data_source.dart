import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/firebase_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/format_exceptions.dart';
import 'package:tiktok_tdd/core/common/errors/exceptions/platform_exceptions.dart';
import 'package:tiktok_tdd/core/utils/helper_functions/functions.dart';
import 'package:tiktok_tdd/src/authentication/data/models/user_model.dart';
import 'package:tiktok_tdd/src/reels/data/models/comment_model.dart';
import 'package:tiktok_tdd/src/reels/data/models/reel_model.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress_ds/video_compress_ds.dart';

abstract interface class ReelDataSource {
  Future<void> uploadReel(
      {required String userId,
      required String videoPath,
      required String caption,
      required String songName});

  Future<ReelModel> likeReel({required String userId, required String videoId});

  Future<CommentModel> addComment(
      {required String comment,
      required String videoId,
      required String userid});

  Future<List<CommentModel>> fetchComments({required String videoId});
  Future<List<ReelModel>> fetchReels();
  Future<UserModel> uploadedReelUser({required String userId});
}

class ReelDataSourceImpl implements ReelDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final TFunctions functions;

  ReelDataSourceImpl(
      {required FirebaseFirestore firestore,
      required FirebaseStorage storage,
      required this.functions})
      : _firestore = firestore,
        _storage = storage;
  @override
  Future<CommentModel> addComment(
      {required String comment,
      required String videoId,
      required String userid}) async {
    try {
      String commentid = const Uuid().v1();

      CommentModel newComment = CommentModel(
          comment: comment,
          commentdate: DateTime.now().toIso8601String(),
          likes: const [],
          userid: userid,
          commentid: commentid);
      // UPDATE COMMENTS COUNT IN REEL DATA
      DocumentSnapshot videoDoc = await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .get();
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .update({
        "commentsCount": (videoDoc.data() as dynamic)['commentsCount'] + 1,
      });

      // ADD COMMENT DATA
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .collection("comments")
          .doc(commentid)
          .set(newComment.toMap());

      return newComment;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<List<CommentModel>> fetchComments({required String videoId}) async {
    try {
      List<CommentModel> comments = [];
      final commentsData = await _firestore
          .collection('videos')
          .doc(videoId)
          .collection('comments')
          .get();
      for (var item in commentsData.docs) {
        comments.add(CommentModel.fromMap(item.data()));
      }
      print(comments.first.comment);
      return comments;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<List<ReelModel>> fetchReels() async {
    try {
      List<ReelModel> reels = [];
      final videosData = await _firestore.collection('videos').get();
      for (var item in videosData.docs) {
        reels.add(ReelModel.fromMap(item.data()));
      }

      return reels;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<ReelModel> likeReel(
      {required String userId, required String videoId}) async {
    try {
      final snapshot = await _firestore.collection('videos').doc(videoId).get();

      if (snapshot.data()!['likes'].contains(userId)) {
        await _firestore.collection("videos").doc(videoId).update({
          'likes': FieldValue.arrayRemove([userId])
        });
      } else {
        await _firestore.collection("videos").doc(videoId).update({
          'likes': FieldValue.arrayUnion([userId])
        });
      }
      final likedReel =
          await _firestore.collection('videos').doc(videoId).get();
      ReelModel reel = ReelModel.fromMap(likedReel.data()!);

      return reel;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<UserModel> uploadedReelUser({required String userId}) async {
    try {
      UserModel user;
      final userData = await _firestore.collection('Users').doc(userId).get();
      if (userData.exists) {
        user = UserModel.fromMap(userData.data()!);
      } else {
        user = UserModel.empty();
      }
      return user;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  @override
  Future<void> uploadReel(
      {required String userId,
      required String videoPath,
      required String caption,
      required String songName}) async {
    try {
      String id = const Uuid().v1();
      String videoUrl =
          await _uploadVideoToStrorage(videoId: id, videoPath: videoPath);

      String thumbnail =
          await _uploadThumbnailToStorage(id: id, videoPath: videoPath);

      ReelModel newReel = ReelModel(
          uid: userId,
          videoUrl: videoUrl,
          videoId: id,
          thumbnail: thumbnail,
          songname: songName,
          caption: caption,
          likes: const [],
          shareCount: 0,
          commentsCount: 0);
      await _firestore.collection('videos').doc(id).set(newReel.toMap());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  Future<String> _uploadVideoToStrorage(
      {required String videoId, required String videoPath}) async {
    try {
      final ref = _storage.ref().child('videos').child(videoId);
      UploadTask uploadTask =
          ref.putFile(File(await functions.compressVideo(videoPath)));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadThumbnailToStorage(
      {required String id, required String videoPath}) async {
    final ref = FirebaseStorage.instance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String username;
  final String description;
  final String imgPost;
  final DateTime datePublished;
  final String postId;
  final String uid;
  final List<dynamic> likes;
  final List<dynamic> savedPosts;

  final String profileImg;

  PostModel({
    required this.username,
    required this.description,
    required this.imgPost,
    required this.datePublished,
    required this.postId,
    required this.uid,
    required this.likes,
    required this.savedPosts,
    required this. profileImg,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      username: json['username'],
      description: json['description'],
      imgPost: json['imgPost'],
      datePublished: (json['datePublished'] as Timestamp).toDate(),
      postId: json['postId'],
      uid: json['uid'],
      likes: List<dynamic>.from(json['likes']),
      savedPosts: List<dynamic>.from(json['savedPosts']),
      profileImg: json['profileImg']  ,
    );
  }

  Map<String, dynamic> toMap() => {

      'username': username,
      'description': description,
      'imgPost': imgPost,
      'datePublished': datePublished,
      'postId': postId,
      'uid': uid,
      'likes': likes,
      'savedPosts': savedPosts,
      'profileImg': profileImg,
    };
  }


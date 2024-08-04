import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  TextEditingController commentController = TextEditingController();

  String newId = FirebaseFirestore.instance.collection('comments').doc().id;


  bool isLoadingComment = false;
  int commentCount = 0;
  bool isLikeAnimating = false;


  void likeAnimation() {
    isLikeAnimating = false;
    emit(LikeAnimationState( isLikeAnimating));
  }


  Stream<int> getCommentCountStream(String postId) {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);

  }


  void uploadComment({
    required String commentText,
    required String postId,
    required String profileImg,
    required String username,
    required String uid,
  }) async {
    if (commentText.isNotEmpty) {
      emit(CommentUploading());
      String commentId = FirebaseFirestore.instance.collection('comments').doc().id;
      try {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          "profilePic": profileImg,
          "username": username,
          "textComment": commentText,
          "datePublished": DateTime.now(),
          "uid": uid,
          "commentId": commentId,
          "commentLikes": [],
        });

        commentController.clear();
        emit(CommentUploaded());
      } catch (e) {
        emit(CommentUploadError(e.toString()));
      }
    } else {
      emit(CommentUploadError("Comment text is empty"));
    }
  }

   Map<String, dynamic> profileData = {};

  void getUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> profileSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      profileData = profileSnapshot.data() ?? {};
       emit(UserProfileLoaded(profileData));
    } catch (e) {
       emit(UserProfileError(e.toString()));
    }
  }

  void deletePost( Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(data["postId"])
          .delete();

      emit(PostDeleted());

    } catch (e) {
      emit(PostError(e.toString()));
    }
  }



  toggleLike({required Map postData}) async {
    try {
      if (postData["likes"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "likes":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });

        emit(PostUnliked());
      } else {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "likes":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
        emit(PostLiked());
      }
    } catch (e) {
      emit(ErrorLike(e.toString()));
    }
  }



  likePost({required Map data}) async {
   isLikeAnimating = true;
    await FirebaseFirestore.instance
        .collection("posts")
        .doc(data["postId"])
        .update({
      "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });

    emit(PostLiked());

  }

  toggleSavedPosts({required Map postData}) async {
    try {
      if (postData["savedPosts"].contains(FirebaseAuth.instance.currentUser!.uid)) {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "savedPosts":
          FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        });

        emit(PostUnsaved());
      } else {
        await FirebaseFirestore.instance
            .collection("posts")
            .doc(postData["postId"])
            .update({
          "savedPosts":
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
        });
        emit(PostSaved());
      }
    } catch (e) {
      emit(ErrorSave(e.toString()));
    }
  }

  List<Map<String, dynamic>> savedPosts = [];

  Future<void> fetchSavedPosts() async {
    emit(SavedPostsLoading());
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('savedPosts', arrayContains: userId)
        .get();

    savedPosts = querySnapshot.docs.map((doc) => doc.data()).toList();
    emit(SavedPostsLoaded(savedPosts));
  }


  Stream<int> getCommentLikeCountStream(String postId, String commentId) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        List likes = snapshot.data()!['commentLikes'] ?? [];
        return likes.length;
      }
      return 0;
    });
  }
  void uploadCommentLike({
    required String postId,
    required String commentId,
    required String uid,
  }) async {
    DocumentReference commentRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    try {
      DocumentSnapshot commentSnapshot = await commentRef.get();

      if (commentSnapshot.exists && commentSnapshot.data() != null) {
        Map<String, dynamic> commentData = commentSnapshot.data()! as Map<String, dynamic>;

        List likes = commentData['commentLikes'] ?? [];

        if (likes.contains(uid)) {
          await commentRef.update({
            'commentLikes': FieldValue.arrayRemove([uid]),
          });
        } else {
          await commentRef.update({
            'commentLikes': FieldValue.arrayUnion([uid]),
          });
        }
      }
    } catch (e) {
      emit(CommentLikeError(e.toString()));
    }
  }





}
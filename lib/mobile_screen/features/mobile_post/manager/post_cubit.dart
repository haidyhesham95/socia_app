import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram/mobile_screen/features/mobile_post/model/post_model.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

import '../../../../utless/style/colors.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  static PostCubit get(context) => BlocProvider.of(context);
  final descriptionController = TextEditingController();
  Uint8List? imgPath;
  String? imgName;


  bool isLoadingPost = false;

  PostModel? postModel ;

  void clear() {
    imgPath = null;
    descriptionController.clear();
    emit(PostInitial());
  }





  Future<void> uploadPost({
    required String imgName,
    required Uint8List imgPath,
    required String description,
    required String profileImg,
    required String username,
    required BuildContext context,
  }) async {
    emit(PostLoading());
    try {
      String url = await uploadImageToStorage(
        imgName: imgName,
        imgPath: imgPath,
        folderName: 'imgPosts/${FirebaseAuth.instance.currentUser!.uid}',
      );

      CollectionReference posts = FirebaseFirestore.instance.collection('posts');

      String newId = posts.doc().id;
      PostModel post = PostModel(
        datePublished: DateTime.now(),
        description: description,
        imgPost: url,
        likes: [],
        savedPosts: [],
        profileImg: profileImg,
        postId: newId,
        uid: FirebaseAuth.instance.currentUser!.uid,
        username: username,
      );

      await posts.doc(newId).set(post.toMap(
      ));

      emit(PostSuccess());
    } on FirebaseAuthException catch (e) {
      emit(PostError(e.message!));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await uploadImage(ImageSource.camera, context);
                            },
                            icon: const Icon(
                              Icons.camera,
                              size: 60.0,
                              color: AppColors.movv,
                            ),
                          ),
                           Text(
                            'Camera',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await uploadImage(ImageSource.gallery, context);
                            },
                            icon: const Icon(
                              Icons.image,
                              size: 60.0,
                              color: AppColors.movv,
                            ),
                          ),
                           Text(
                            'Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7),fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadImageToStorage({
    required String imgName,
    required Uint8List imgPath,
    required String folderName,
  }) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('$folderName/$imgName');
      UploadTask uploadTask = ref.putData(imgPath);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }


  Future<void> uploadImage(ImageSource source, BuildContext context) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    if (pickedImg != null) {
      imgPath = await pickedImg.readAsBytes();
      imgName = "${Random().nextInt(9999999)}_${basename(pickedImg.path)}";
      emit(PostImagePicked(imgPath!));
    } else {
      emit(PostError("No image selected"));
    }
  }



  // Map<String, dynamic> profileData = {};
  //
  // Future<void> getProfileData() async {
  //   isLoadingPost = true;
  //   emit(ProfileLoading());
  //
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //
  //     profileData = snapshot.data() ?? {};
  //
  //     isLoadingPost = false;
  //     emit(ProfileSuccess());
  //   } catch (e) {
  //     isLoadingPost = false;
  //     emit(ProfileError(error: e.toString()));
  //   }
  // }
  // Map<String, dynamic> post = {};
  //
  // getPosts() async {
  //   emit(PostLoading());
  //   try {
  // DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('posts')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //
  //     post = snapshot.data() ?? {};
  //     emit(PostSuccess());
  //   } catch (e) {
  //     emit(PostError(e.toString()));
  //   }
  // }

  Map<String, dynamic> profileData = {};
  Map<String, dynamic> post = {};

/*
  Future<void> getProfileAndPosts() async {
    emit(PostLoading());
    try {
      // Fetch profile data
      DocumentSnapshot<Map<String, dynamic>> profileSnapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      profileData = profileSnapshot.data() ?? {};


      // Fetch posts
      DocumentSnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore
          .instance
          .collection('posts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      post = postSnapshot.data() ?? {};

      emit(PostSuccess());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
*/

  Future<void> getProfileAndPosts() async {
    emit(PostLoading());
    try {
      // Listen to profile data changes in real-time
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((profileSnapshot) async {
        profileData = profileSnapshot.data() ?? {};

        // Fetch posts after updating profileData
        DocumentSnapshot<Map<String, dynamic>> postSnapshot = await FirebaseFirestore
            .instance
            .collection('posts')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        post = postSnapshot.data() ?? {};

        emit(PostSuccess());
      });
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

}
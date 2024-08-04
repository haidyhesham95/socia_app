import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram/auth/register/view/manager/register_cubit.dart';
import 'package:path/path.dart';


import 'package:meta/meta.dart';

import '../../../../auth/login/view/mobile_login.dart';
import '../../../../auth/register/view/model/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  Uint8List? imgPath;
  String? imgName;

  final picker = ImagePicker();

  Map<String, dynamic> profileData = {};
  bool isLoading = true;
  int followers = 0;
  int following = 0;
  int postCount = 0;
  bool showFollow = true;

  void changeShowFollowState() {
    showFollow = !showFollow;
    emit(ChangeShowFollowState(showFollow: showFollow));
  }


void unFollowUser(String uid, ) async {
  followers--;
  changeShowFollowState();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .update({
  "followers": FieldValue.arrayRemove(
  [FirebaseAuth.instance.currentUser!.uid])
  });

  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
  "following":
  FieldValue.arrayRemove([uid])
  });
}

void followUser(String uid) async {

  followers++;
  changeShowFollowState();
  await FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .update({
    "followers": FieldValue.arrayUnion(
        [FirebaseAuth.instance.currentUser!.uid])
  });

  await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    "following":
    FieldValue.arrayUnion([uid])
  });


}

  bool isLoadingLogout = false;

  Future<void> signOut(BuildContext context) async {
    isLoadingLogout = true;
    emit((SignOutLoading()));

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'token': ''});
        await FirebaseAuth.instance.signOut();
      }

      isLoadingLogout = false;
      emit(SignOutSuccess());

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MobileLogin()),
            (route) => false,
      );
    } catch (e) {
      isLoadingLogout = false;
      emit(SignOutError(error: e.toString()));
    }
  }

  Future<void> getProfileData( String uid ) async {
    isLoading = true;
    emit(ProfileLoading());

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(
          uid
        //  FirebaseAuth.instance.currentUser!.uid
      )
          .get();

      profileData = snapshot.data() ?? {};
      nameController.text = profileData['name'];
      titleController.text = profileData['title'];
      followers = profileData['followers'].length ;
      following = profileData['following'].length ;
      showFollow = profileData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      var snapshotPosts = await FirebaseFirestore.instance.collection('posts').where(
          'uid', isEqualTo: uid).get();
      postCount = snapshotPosts.docs.length;
      isLoading = false;
      emit(ProfileSuccess());
    } catch (e) {
      isLoading = false;
      emit(ProfileError(error: e.toString()));
    }
  }



  Future<String> uploadImageToFirebase(Uint8List imgData, String userId) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('ProfileImage/$userId.jpg');
      UploadTask uploadTask = ref.putData(imgData);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw e;
    }
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(ImageLoading());
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        imgName = basename(pickedImg.path);
        emit(PickImageSuccess(imgPath: imgPath!, imgName: imgName!));
      } else {
        print("No image selected");
      }
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  Future<void> editProfile({required String uid}) async {
    emit(ProfileLoading());
    try {
      if (imgPath != null) {
        String imageUrl = await uploadImageToFirebase(imgPath!, uid);
        profileData['image'] = imageUrl;
      }
      profileData['name'] = nameController.text;
      profileData['title'] = titleController.text;
      await FirebaseFirestore.instance.collection('users').doc(uid).update(profileData);
      await getProfileData(uid);
      emit(ChangeInformation());
      Fluttertoast.showToast(msg: "Information has been changed");
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/generated/assets.dart';
import 'package:instgram/mobile_screen/features/mobile_home/manager/home_cubit.dart';
import 'package:instgram/utless/wiget/circle_image.dart';
import 'package:intl/intl.dart';

import '../../../../utless/style/colors.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen(
      {super.key, required this.data, required this.commentText});

  final Map data;
  final bool commentText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(data["postId"])
                  .collection("comments")
                  .orderBy("datePublished", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.movv,
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No comments yet. Be the first to comment!'),
                  );
                }

                return BlocConsumer <HomeCubit, HomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    final cubit = HomeCubit.get(context);

                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 25);
                      },
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> commentData =
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>;

                        return StreamBuilder<int>(
                          stream: cubit.getCommentLikeCountStream(
                            data["postId"],
                            commentData['commentId'],
                          ),
                          builder: (context, likeSnapshot) {
                            if (!likeSnapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            int likeCount = likeSnapshot.data!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 8),
                                      child: circleImage(
                                        context,
                                        backgroundImage: NetworkImage(
                                            commentData['profilePic']),
                                        radius: 20,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              commentData['username'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            const SizedBox(width: 11),
                                            Text(
                                              commentData['textComment'],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          DateFormat('MMM d, y').format(
                                              commentData['datePublished']
                                                  .toDate()),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final uid =
                                            FirebaseAuth.instance.currentUser?.uid;
                                        if (uid != null) {
                                          cubit.uploadCommentLike(
                                            postId: data["postId"],
                                            commentId: commentData['commentId'],
                                            uid: uid,
                                          );
                                        }
                                      },
                                      icon: commentData['commentLikes']
                                          ?.contains(FirebaseAuth.instance
                                          .currentUser?.uid) ==
                                          true ? const Icon(CupertinoIcons.heart_fill, color: AppColors.movv) : const Icon(
                                        CupertinoIcons.heart,color: AppColors.movv,
                                      ),
                                    ),
                                    Text('$likeCount'),

                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          commentText
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),

                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: cubit.profileData['image'] != null
                      //       ? NetworkImage(cubit.profileData['image'])
                      //       : AssetImage('assets/images/profileavatar.jpg'), // Replace with your default image path
                      // ),
                      BlocConsumer<HomeCubit, HomeState>(
                        listener: (context, state) {
                          if (state is CommentUploaded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Comment Uploaded Successfully',
                                    style: TextStyle(
                                      color: AppColors.movv,
                                    )),
                                backgroundColor: Colors.white,
                              ),
                            );
                          } else if (state is CommentUploadError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${state.error}')),
                            );
                          }
                        },
                        builder: (context, state) {
                          final cubit = HomeCubit.get(context);

                          return Expanded(
                            child: Card(
                              color: Colors.white,
                              child: TextField(
                                controller: cubit.commentController,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: "     Add a comment...",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: CircleAvatar(
                                      backgroundImage: cubit
                                                  .profileData['image'] !=
                                              null
                                          ? NetworkImage(
                                              cubit.profileData['image'])
                                          : const AssetImage(
                                              'assets/images/profileavatar.jpg'),
                                      child: cubit.profileData['image'] != null
                                          ? null
                                          : Image.asset(Assets.imagesProfile),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 30,
                                    minHeight: 30,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (cubit.profileData['image'] != null &&
                                          cubit.profileData['name'] != null &&
                                          cubit.profileData['id'] != null) {
                                        cubit.uploadComment(
                                          commentText:
                                              cubit.commentController.text,
                                          profileImg:
                                              cubit.profileData["image"] ?? '',
                                          username:
                                              cubit.profileData["name"] ?? '',
                                          postId: data["postId"],
                                          uid: cubit.profileData['id'] ?? '',
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'User profile data is missing')),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_upward,
                                      color: AppColors.movv,
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  disabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

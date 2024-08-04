import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/comment_screen.dart';

import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/heart_animation.dart';
import '../manager/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../utless/style/colors.dart';
import '../manager/home_cubit.dart';

class PostActions extends StatelessWidget {
  final Map<String, dynamic> data;
  final HomeCubit cubit;
  final int commentCount;
  final bool isLoading; // New isLoading flag

  const PostActions({
    super.key,
    required this.data,
    required this.cubit,
    required this.commentCount,
    required this.isLoading, // Accept isLoading flag as a parameter
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show shimmer effect while loading
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.heart, color: AppColors.movv),
                SizedBox(width: 8),
                Text('0 likes', style: TextStyle(color: AppColors.movv)),
              ],
            ),
            Row(
              children: [
                Icon(CupertinoIcons.chat_bubble, color: AppColors.movv),
                SizedBox(width: 8),
                Text('0', style: TextStyle(color: AppColors.movv)),
              ],
            ),
            Icon(CupertinoIcons.bookmark, color: AppColors.movv),
          ],
        ),
      );
    }

    // Show actual content when data is loaded
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            LikeAnimation(
              isAnimating: data['likes']
                  .contains(FirebaseAuth.instance.currentUser!.uid),
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await cubit.toggleLike(postData: data);
                },
                icon: data['likes'].contains(
                    FirebaseAuth.instance.currentUser!.uid)
                    ? const Icon(
                  CupertinoIcons.heart_fill,
                  color: AppColors.movv,
                )
                    : const Icon(
                  CupertinoIcons.heart,
                  color: AppColors.movv,
                ),
              ),
            ),
            Container(
              child: Text(
                '${data['likes'].length} ${data['likes'].length > 1 ? 'likes' : 'like'}',
                style: const TextStyle(color: AppColors.movv),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CommentScreen(data: data, commentText: false),
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.chat_bubble,
                color: AppColors.movv,
              ),
            ),
            Container(
              child: Text(
                "$commentCount ",
                style: const TextStyle(color: AppColors.movv),
              ),
            ),
          ],
        ),
        Row(
          children: [
            LikeAnimation(
              isAnimating: data['savedPosts']
                  .contains(FirebaseAuth.instance.currentUser!.uid),
              smallLike: true,
              child: IconButton(
                onPressed: () async {
                  await cubit.toggleSavedPosts(postData: data);
                },
                icon: data['savedPosts'].contains(
                    FirebaseAuth.instance.currentUser!.uid)
                    ? const Icon(
                  CupertinoIcons.bookmark_fill,
                  color: AppColors.movv,
                )
                    : const Icon(
                  CupertinoIcons.bookmark,
                  color: AppColors.movv,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


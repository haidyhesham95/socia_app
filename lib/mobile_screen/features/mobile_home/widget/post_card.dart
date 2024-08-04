import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/post_action.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/post_header.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/post_image.dart';


import '../../../../utless/wiget/heart_animation.dart';
import '../../mobile_post/widget/dialog.dart';
import '../manager/home_cubit.dart';

class PostCard extends StatelessWidget {
  final Size size;
  final Map<String, dynamic>? data;
  final HomeCubit cubit;

  const PostCard({
    super.key,
    required this.size,
    required this.data,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          PostHeader(
            data: data,
            onPressed:  () {
              showmodel(
                  context: context,
                  data: data!,
                  onPressed: () {
                    cubit.deletePost(data!);
                    Navigator.pop(context);
                  });
            },
          ),
          SizedBox(height: 12),
          GestureDetector(
            onDoubleTap: () {
              cubit.likePost(data: data!);
            },
            child: Stack(
            alignment: Alignment.center,
            children: [
              PostImage(size: size, data: data!),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: cubit.isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: cubit.isLikeAnimating,
                  duration: const Duration(milliseconds: 400),
                  onEnd: () {
                    cubit.likeAnimation();
                  },
                  child: Icon(Icons.favorite, color: Colors.white, size: 100),
                ),
              ),
            ],
          ),
          ),
          SizedBox(height: 10),
            StreamBuilder(
              stream: cubit.getCommentCountStream(data!['postId']),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return PostActions(
                    data: data!,
                    cubit: cubit,
                    commentCount: 0,
                    isLoading: true,
                  );
                }
                return PostActions(
                  data: data!,
                  cubit: cubit,
                  commentCount: snapshot.data!,
                  isLoading: false,
                );
              },
            ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

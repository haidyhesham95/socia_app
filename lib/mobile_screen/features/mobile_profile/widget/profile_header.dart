import 'package:flutter/material.dart';

import '../../../../utless/wiget/circle_image.dart';
import '../manager/profile_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key,required this.cubit});
final ProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        circleImage(
          context,
          radius: 30,

          backgroundImage: NetworkImage(cubit.profileData["image"]),


        ),

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(cubit.postCount.toString()),
                  const Text('posts'),
                ],
              ),
              const SizedBox(width: 18),
              Column(
                children: [
                  Text(cubit.followers.toString()),
                  const Text('followers'),
                ],
              ),
              const SizedBox(width: 18),
              Column(
                children: [
                  Text(cubit.following.toString()),
                  const Text('following'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

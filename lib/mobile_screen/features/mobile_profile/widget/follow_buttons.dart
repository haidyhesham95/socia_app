import 'package:flutter/material.dart';

import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/elevated_widget.dart';
import '../manager/profile_cubit.dart';
import 'chat_screen.dart';


class FollowButtons extends StatelessWidget {
  const FollowButtons({super.key, required this.uid,required this.cubit});
  final String uid;
  final ProfileCubit cubit ;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        cubit.showFollow
            ? elevatedButton(
          size,
          context,
          onpressed: () {
            cubit.unFollowUser(uid);
          },
          horizontal: 28,

          text: 'UnFollow',
          textColor: Colors.white,
          backgroundColor: MaterialStateProperty.all(
            AppColors.movv.withOpacity(0.7),
          ),
        )
            : elevatedButton(
          size,
          context,
          onpressed: () {
            cubit.followUser(uid);
          },
          horizontal: 28,

          text: 'Follow',
          textColor: Colors.white,
          backgroundColor: MaterialStateProperty.all(
            AppColors.movv.withOpacity(0.7),
          ),
        ),
        elevatedButton(
          size,
          context,
          horizontal: 28,
          onpressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                    peerId: uid,
                    peerImage: cubit.profileData["image"],
                    peerName: cubit.profileData["name"]),
              ),
            );
          },
          text: 'Message',
        )
      ],
    );
  }
}

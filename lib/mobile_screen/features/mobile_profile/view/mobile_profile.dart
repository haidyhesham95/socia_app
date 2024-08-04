import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/mobile_screen/features/mobile_profile/widget/follow_buttons.dart';
import 'package:instgram/mobile_screen/features/mobile_profile/widget/profile_buttons.dart';
import 'package:instgram/mobile_screen/features/mobile_profile/widget/profile_header.dart';
import 'package:instgram/mobile_screen/features/mobile_profile/widget/profile_post.dart';
import 'package:instgram/utless/style/colors.dart';
import '../manager/profile_cubit.dart';


class MobileProfile extends StatelessWidget {
  final String uid;

  const MobileProfile({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle:  true,
        title: const Text('Profile'),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..getProfileData(uid),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            ProfileCubit cubit = ProfileCubit.get(context);
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ProfileHeader(cubit: cubit),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(cubit.profileData["name"] ?? ''),
                      Text(cubit.profileData["title"] ?? ''),
                    ],
                  ),
                ),
                const Divider(thickness: 0.3, color: AppColors.mov,),
                const SizedBox(height: 8),
                uid == FirebaseAuth.instance.currentUser!.uid
                    ? ProfileButtons(uid: uid, cubit: cubit)
                    : FollowButtons(uid: uid, cubit: cubit),
                const SizedBox(height: 8),
                const Divider(thickness: 0.3, color: AppColors.mov,),
                const SizedBox(height: 20),
               ProfilePost(uid: uid)
              ],
            );
          },
        ),
      ),
    );
  }
}

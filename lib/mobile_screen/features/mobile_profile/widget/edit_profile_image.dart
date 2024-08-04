import 'package:flutter/material.dart';
import 'package:instgram/utless/style/colors.dart';

import '../../../../generated/assets.dart';
import '../manager/profile_cubit.dart';

Widget profileImageSection(BuildContext context, ProfileCubit cubit) {
   return GestureDetector(
    onTap: () async {
      await cubit.pickImageFromGallery();
    },
    child: Stack(
      children: [ Container(
        padding: const EdgeInsets.all(2),
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.movv.withOpacity(0.5),
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: cubit.imgPath != null
              ? MemoryImage(cubit.imgPath!)
              : cubit.profileData["image"] != null
              ? NetworkImage(cubit.profileData["image"] )
              : AssetImage('assets/images/profile.png') as ImageProvider,

          child: cubit.imgPath != null
              ? null
              : cubit.profileData["image"] != null
              ? null
              : const Icon(Icons.person, size: 50, color: Colors.white),
        ),
      ),
        Align(
          alignment: Alignment.topRight,
          widthFactor: 4,
          child: Icon(Icons.edit,color: AppColors.movv,),

        ),
  ],
    ),
  );
}
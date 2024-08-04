import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../style/colors.dart';

Widget circleImage(BuildContext context, {required double radius,required ImageProvider<Object>? backgroundImage}) {
  return Container(

    padding: const EdgeInsets.all(2),
    decoration:  BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.movv.withOpacity(0.5),
    ),
    child: CircleAvatar(
      radius: radius,
      backgroundImage: backgroundImage,
    ),
  );
}

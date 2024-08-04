import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';
import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/circle_image.dart';

class PostHeader extends StatelessWidget {
  final Map<String, dynamic>? data;
  final Function()? onPressed;

  const PostHeader({
    super.key,
    required this.data,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider placeholderImage = AssetImage(Assets.imagesProfile);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 8),

            circleImage(
              context,
              backgroundImage: NetworkImage(data!['profileImg']) ,
              radius: 20,
            ),
            const SizedBox(width: 15),
            Text(
              data!['username'],
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.movv,
          ),
        ),
      ],
    );
  }
}

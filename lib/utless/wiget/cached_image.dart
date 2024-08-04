import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../style/colors.dart';
class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    this.borderRadius,
   required this.link,
    this.width,
    this.height, this.fit,
  });
  final double? borderRadius;
  final String? link;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
     borderRadius: BorderRadius.circular(borderRadius ?? 15),
      child: link != null
          ?
      FadeInImage.assetNetwork(
        fit: fit,
        image: link!,
        width: width ??  double.infinity,
        height: height ?? size.height * 0.35,
        fadeInDuration: const Duration(milliseconds: 300),
        placeholder:Assets.imagesImag,

      )

          : Container(
        width: width ?? 30,
        height: height ?? 30,
        decoration: const BoxDecoration(
          color: AppColors.movv,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

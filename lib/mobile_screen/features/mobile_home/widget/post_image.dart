import 'package:flutter/material.dart';
import 'package:instgram/utless/wiget/cached_image.dart';
import 'package:shimmer/shimmer.dart';



class PostImage extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> data;

  const PostImage({super.key, required this.size, required this.data});

  @override
  Widget build(BuildContext context) {
    return  CachedImage(
      link: data['imgPost'],
      fit: BoxFit.cover,
      borderRadius: 5,
    );
    //   Image.network(
    //   data['imgPost'],
    //   loadingBuilder: (context, child, progress) {
    //     if (progress == null) return child;
    //     return Shimmer.fromColors(
    //       baseColor: Colors.grey.shade300,
    //       highlightColor: Colors.grey.shade100,
    //       child: Container(
    //         height: size.height * 0.35,
    //         width: double.infinity,
    //         color: Colors.grey,
    //       ),
    //     );
    //   },
    //   fit: BoxFit.cover,
    //   height: size.height * 0.35,
    //   width: double.infinity,
    // );
  }
}

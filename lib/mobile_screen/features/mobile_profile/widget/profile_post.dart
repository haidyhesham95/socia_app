import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/cached_image.dart';

class ProfilePost extends StatelessWidget {
  const ProfilePost({super.key, required this.uid});

  final String uid ;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
        // }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Column(
              children: [
                 Icon(Icons.error,color: AppColors.movv,size: 35,),
                Text('No posts found'),
              ],
            ));
          }
          return Expanded(
            child: GridView.builder(
              padding: size.width > 600
                  ? const EdgeInsets.all(55)
                  : const EdgeInsets.all(3),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 3,
                    child: CachedImage(
                      borderRadius: 8,
                      link: snapshot.data!.docs[index]['imgPost'],
                      width: double.infinity,
                      height: size.height * 0.35,
                      fit: BoxFit.cover,
                    )
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: Image.network(
                  //     snapshot.data!.docs[index]['imgPost'],
                  //     loadingBuilder: (context, child, progress) {
                  //       return progress == null
                  //           ? child
                  //           : const Center(child: CircularProgressIndicator( color: AppColors.movv,));
                  //     },
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                );
              },
            ),
          );
        }
        return const Text('');
      },
    );
  }
}

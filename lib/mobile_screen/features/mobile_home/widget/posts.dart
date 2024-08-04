import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/mobile_screen/features/mobile_home/manager/home_cubit.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/post_card.dart';

import '../../../../utless/style/colors.dart';

class Posts extends StatelessWidget {
  Posts({super.key});
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('posts').orderBy("datePublished", descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColors.movv,));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No posts yet'));
        }

        return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),

            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;

              return BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                //   if (state is CommentUploaded) {
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comment Uploaded Successfully')));
                //   } else if (state is CommentUploadError) {
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
                //   }
                 },
                builder: (context, state) {
                  final cubit = HomeCubit.get(context);
                  return PostCard(size: size, data: data, cubit: cubit);
                },
              );
            },
          ),
        );
      },
    );
  }
}






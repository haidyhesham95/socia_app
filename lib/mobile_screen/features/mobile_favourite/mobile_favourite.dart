import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/assets.dart';
import '../../../utless/style/colors.dart';
import '../mobile_home/manager/home_cubit.dart';
import '../mobile_home/widget/post_card.dart';

class MobileFavourite extends StatelessWidget {
  const MobileFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);

    homeCubit.fetchSavedPosts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Favourite Posts'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is SavedPostsLoaded) {
                  if (state.savedPosts.isEmpty) {
                    return  Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(Assets.imagesNofav),
                        SizedBox(height: 15),
                        Text('No favourite posts.', style: TextStyle(fontSize: 20,color: AppColors.movv.withOpacity(0.7),fontWeight: FontWeight.w500),),
                      ],
                    ));
                  }
            
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 20);
                    },
            
                    itemCount: state.savedPosts.length,
                    itemBuilder: (context, index) {
                      final post = state.savedPosts[index];
                      return PostCard(
                        size: MediaQuery.of(context).size,
                        data: post,
                        cubit: homeCubit,
                      );
                    },
                  );
                } else if (state is SavedPostsLoading) {
                  return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
          ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utless/style/colors.dart';
import 'manager/post_cubit.dart';



class MobilePost extends StatelessWidget {
  const MobilePost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        final cubit = PostCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: cubit.imgPath == null
              ? null
              : AppBar(
            actions: [
              TextButton(
                onPressed: () async {
                  await cubit.uploadPost(
                    imgName: cubit.imgName!,
                    imgPath: cubit.imgPath!,
                    description: cubit.descriptionController.text,
                    profileImg: cubit.profileData["image"] ?? '',
                    username: cubit.profileData["name"] ?? '',
                    context: context,
                  );

                  cubit.clear();


                },
                child: const Text(
                  "Post",
                  style: TextStyle(
                    color: AppColors.movv,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                cubit.clear();

                print('back');

              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: cubit.imgPath == null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.showImagePicker(context);
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 55,
                    color: AppColors.movv,
                   // color: AppColors.ground,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Upload Post",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                   // color: AppColors.movv,
                  ),
                ),
              ],
            ),
          )
              : Column(
            children: [
              if (state is PostLoading)
                 LinearProgressIndicator(color: AppColors.movv.withOpacity(0.7) ,)
              else
                const Divider(
                  thickness: 1,
                  height: 30,
                   color: AppColors.movv,
                ),
              SizedBox(height: 15,),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),

                      Row(
                        children: [
                          SizedBox(width: 10,),

                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            NetworkImage(cubit.profileData["image"] ?? ''),
                          ),
                          SizedBox(width: 10,),
                          Text(cubit.profileData["name"] ?? ''),

                        ],
                      ),
                      SizedBox(height: 10,),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Image.memory(cubit.imgPath!,fit: BoxFit.cover,height: 200,),
                      // ),
                      Container(
                       // width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(cubit.imgPath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // SizedBox(height: 5,),
                      //
                      // TextField(
                      //   controller: cubit.descriptionController,
                      //   maxLines: 2,
                      //   decoration: const InputDecoration(
                      //     hintText: "Write a caption...",
                      //     border: InputBorder.none,
                      //   ),
                      //  ),

                    ],
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // CircleAvatar(
              //     //   radius: 28,
              //     //   backgroundImage:
              //     //   NetworkImage(cubit.profileData["image"] ?? ''),
              //     // ),
              //     SizedBox(width: 10,),
              //     Container(
              //       width: 70,
              //       height: 74,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: MemoryImage(cubit.imgPath!),
              //           fit: BoxFit.cover,
              //         ),
              //       ),
              //     ),
              //     SizedBox(width: 10,),
              //     Expanded(
              //       //width: MediaQuery.of(context).size.width * 0.3,
              //       child: Padding(
              //         padding: const EdgeInsets.only(top: 10),
              //         child: TextField(
              //           controller: cubit.descriptionController,
              //           maxLines: 5,
              //           decoration: const InputDecoration(
              //             hintText: "Write a caption...",
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //     ),
              //
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}

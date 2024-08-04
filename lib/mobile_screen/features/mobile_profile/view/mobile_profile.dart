import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/utless/style/colors.dart';
import 'package:instgram/utless/wiget/cached_image.dart';
import 'package:instgram/utless/wiget/elevated_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../utless/wiget/circle_image.dart';
import '../manager/profile_cubit.dart';
import '../widget/chat_screen.dart';
import 'edit_profile.dart';

class MobileProfile extends StatelessWidget {
  final String uid;

  const MobileProfile({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle:  true,
        title: const Text('Profile'),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit()
          ..getProfileData(uid), // fetch user profile using the uid
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
                Row(
                  children: [
                    const SizedBox(width: 10),
                    circleImage(
                      context,
                      radius: 30,

                     backgroundImage: NetworkImage(cubit.profileData["image"]),


                    ),

                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(cubit.postCount.toString()),
                              const Text('posts'),
                            ],
                          ),
                          const SizedBox(width: 18),
                          Column(
                            children: [
                              Text(cubit.followers.toString()),
                              const Text('followers'),
                            ],
                          ),
                          const SizedBox(width: 18),
                          Column(
                            children: [
                              Text(cubit.following.toString()),
                              const Text('following'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          elevatedButton(
                            size,
                            context,
                            onpressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(uid: uid),
                                ),
                              );
                              cubit.getProfileData(uid);
                            },
                            text: 'Edit Profile',
                            textColor: Colors.white,
                            icon: Icons.edit,
                            backgroundColor: MaterialStateProperty.all(
                              AppColors.movv.withOpacity(0.7),
                            ),
                          ),
                          elevatedButton(
                            size,
                            context,
                            onpressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Center(child: Text('Logout')),
                                  content:
                                      const Text("Are you sure you want to logout?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(3),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColors.movv),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStateProperty.all(3),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            side: MaterialStateProperty.all(
                                              BorderSide(
                                                color: AppColors.movv.withOpacity(0.7),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog first
                                            cubit.signOut(
                                                context); // Call the signOut function
                                          },
                                          child: const Text('Logout',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            text: 'Logout',
                            icon: Icons.logout,
                            backgroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cubit.showFollow
                              ? elevatedButton(
                                  size,
                                  context,
                                  onpressed: () {
                                    cubit.unFollowUser(uid);
                                  },
                            horizontal: 28,

                            text: 'UnFollow',
                                  textColor: Colors.white,
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.movv.withOpacity(0.7),
                                  ),
                                )
                              : elevatedButton(
                                  size,
                                  context,
                                  onpressed: () {
                                    cubit.followUser(uid);
                                  },
                            horizontal: 28,

                            text: 'Follow',
                                  textColor: Colors.white,
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.movv.withOpacity(0.7),
                                  ),
                                ),
                          elevatedButton(
                            size,
                            context,
                            horizontal: 28,
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      peerId: uid,
                                      peerImage: cubit.profileData["image"],
                                      peerName: cubit.profileData["name"]),
                                ),
                              );
                            },
                            text: 'Message',
                          )
                        ],
                      ),
                const SizedBox(height: 8),
                const Divider(thickness: 0.3, color: AppColors.mov,),
                const SizedBox(height: 20),
                FutureBuilder(
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
                            const Icon(Icons.error,color: AppColors.movv,size: 35,),
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
                   // return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

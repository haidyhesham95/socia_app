import 'package:flutter/material.dart';

import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/elevated_widget.dart';
import '../manager/profile_cubit.dart';
import '../view/edit_profile.dart';

class ProfileButtons extends StatelessWidget {
 const  ProfileButtons({super.key, required this.uid, required this.cubit});
 final String uid;
  final ProfileCubit cubit ;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
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
    );
  }
}

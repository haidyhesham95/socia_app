import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utless/style/colors.dart';
import '../../../../utless/wiget/button_widget.dart';
import '../../../../utless/wiget/text_field.dart';
import '../manager/profile_cubit.dart';
import '../widget/edit_profile_image.dart';




class EditProfile extends StatelessWidget {
  const EditProfile({super.key, required this.uid} );

  final String uid ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => ProfileCubit()..getProfileData(uid),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                // if (state is ProfileSuccess) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Profile loaded successfully')),
                //   );
                // } else if (state is ProfileError) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text('Error: ${state.error}')),
                //   );
                // }
              },
              builder: (context, state) {
                ProfileCubit cubit = ProfileCubit.get(context);
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator( color: AppColors.movv,));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profileImageSection(context, cubit),
                    const SizedBox(height: 30),
                    TextFieldWidget(
                      hint: 'Edit Name:',
                      label: 'Edit your name',
                      controller: cubit.nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      hint: 'Edit Title:',
                      label: 'Edit your title',
                      controller: cubit.titleController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: ButtonWidget(
                        text: 'Submit',
                        hasElevation: true,
                        onPressed: () async {
                          await cubit.editProfile(uid: uid);

                          Navigator.pop(context);


                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }


}

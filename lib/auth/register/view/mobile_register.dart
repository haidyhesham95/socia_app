import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/auth/register/view/manager/register_cubit.dart';
import 'package:instgram/generated/assets.dart';
import 'package:instgram/utless/wiget/text_field.dart';
import '../../../utless/style/colors.dart';
import '../../../utless/wiget/button_widget.dart';
import '../../../utless/wiget/custom_text_button.dart';
import 'model/user_model.dart';

class MobileRegister extends StatelessWidget {
  const MobileRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: size.width > 600
              ? EdgeInsets.symmetric(horizontal: size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              builder: (context, state) {
                RegisterCubit cubit = RegisterCubit.get(context);

                return Form(
                  key: cubit.registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          cubit.pickImageFromGallery();
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage: cubit.imgPath != null ? MemoryImage(cubit.imgPath!) : null,
                          child: cubit.imgPath == null ? Image.asset(Assets.imagesProfile): null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        hint: 'Enter your name',
                        label: 'Name',
                        errorMessage:"Please insert your name"   ,
                        controller:cubit.nameController ,
                        leading: const Icon(Icons.person),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        hint: 'Enter your Title',
                        label: 'Title',
                        errorMessage:"Please insert your title"   ,
                        controller:cubit.titleController ,
                        leading: const Icon(Icons.title),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        hint: 'Enter your email',
                        label: 'Email',
                        errorMessage:"Please insert your email"   ,
                        controller:cubit.emailController ,
                        leading: const Icon(Icons.email),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWidget(
                        hint: 'Enter your password',
                        label: 'Password',
                        errorMessage:'Please insert your password' ,
                        controller:cubit.passwordController ,
                        leading: const Icon(Icons.lock),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: cubit.isShowSignUpPassword,
                        trailingIcon: GestureDetector(
                          onTap: () {
                            cubit.changeSignUpPasswordVisibility();
                          },
                          child: Visibility(
                            visible: !cubit.isShowSignUpPassword,
                            replacement: const Icon(Icons.visibility_off),
                            child: const Icon(Icons.visibility),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (cubit.isLoadingRegister) Center(child: const CircularProgressIndicator(color: AppColors.movv,)) else
                      ButtonWidget(
                        hasElevation: true,
                        text: 'Register',
                        onPressed: () {
                          if (cubit.registerFormKey.currentState!.validate()) {
                            cubit.register(context,
                                userModel: UserModel(
                                    title: cubit.titleController.text,
                                    email: cubit.emailController.text,
                                    name: cubit.nameController.text,
                                    image: cubit.imgPath.toString(),
                                    following:[],
                                    followers :[]
                                ),
                                password: cubit.passwordController.text);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomTextButton(
                        text: 'Do you have an account ?',
                        data: ' Sign In',
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

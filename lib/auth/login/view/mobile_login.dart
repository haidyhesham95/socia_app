import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/auth/login/manager/login_cubit.dart';
import 'package:instgram/utless/wiget/text_field.dart';

import '../../../generated/assets.dart';
import '../../../utless/style/colors.dart';
import '../../../utless/wiget/button_widget.dart';
import '../../../utless/wiget/custom_text_button.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Padding(
          padding:size.width>600? EdgeInsets.symmetric(horizontal:size.width/3): const EdgeInsets.symmetric(horizontal: 15),

          child: SingleChildScrollView(
            child: BlocConsumer<LoginCubit,LoginState>(
              listener: (context,state){},
              builder: (context,state){
                LoginCubit cubit = LoginCubit.get(context);
                return Form(
                  key: cubit.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: size.height * 0.3,
                      width: double.infinity,
                      child: Image.asset(
                        Assets.imagesLogin,
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(height: 20),


                  TextFieldWidget(
                    hint: 'Enter your email',
                    label: 'Email',
                    controller: cubit.emailController,
                    errorMessage: 'Email must not be empty',
                    leading: const Icon(Icons.email),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 25),

                  TextFieldWidget(
                    isPassword: cubit.isShowLoginPassword,

                    hint: 'Enter your password',
                    label: 'Password',
                    controller: cubit.passwordController,
                    errorMessage: 'Password must not be empty',
                    leading: const Icon(Icons.lock),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    trailingIcon: GestureDetector(
                      onTap: () {
                        cubit.changeLoginPasswordVisibility();
                      },
                      child: Visibility(
                        visible: !cubit.isShowLoginPassword,
                        replacement: const Icon(Icons.visibility_off, color: Colors.black),
                        child: const Icon(Icons.visibility, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  cubit.isLoadingLogin
                      ? const CircularProgressIndicator(color: AppColors.movv,)
                      : ButtonWidget(
                    hasElevation: true,
                    text: 'Login',
                    onPressed: () {
                      if (cubit.loginFormKey.currentState!.validate()) {
                        cubit.signInWithEmailAndPassword(
                          cubit.emailController.text,
                          cubit.passwordController.text,
                          context,
                        );
                        cubit.emailController.clear();
                        cubit.passwordController.clear();
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  CustomTextButton(
                    text: 'Don\'t have an account ?',
                    data: ' Sign up',
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
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

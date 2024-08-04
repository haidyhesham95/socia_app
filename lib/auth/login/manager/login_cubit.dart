import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instgram/auth/register/view/model/user_model.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoadingLogin = false;
  UserModel? registerModel;

  // Future signInWithEmailAndPassword(String email,String password,context)async{
  //   isLoadingLogin = true;
  //   emit(LoginLoading());
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     isLoadingLogin = false;
  //
  //     emit(LoginSuccess());
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Alert'),
  //           content: const Text('Login Sucess'),
  //           actions: [
  //             TextButton(
  //               child: const Text('Close'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     Navigator.pushNamed(context, '/responsiveScreen');
  //   }on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //            emit(LoginError(error: e.code .toString()));
  //     } else if (e.code == 'wrong-password') {
  //            emit(LoginError(error: e.code .toString()));
  //
  //
  //     }
  //
  //   } catch (e) {
  //     isLoadingLogin = false;
  //
  //     emit(LoginError(error: ''));
  //
  //   }
  //
  // }

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    isLoadingLogin = true;
    emit(LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      isLoadingLogin = false;
      emit(LoginSuccess());



      // // Delay to allow dialog to be seen before navigation
      // await Future.delayed(Duration(milliseconds: 500));
      Navigator.pushNamed(context, '/responsiveScreen');
    } on FirebaseAuthException catch (e) {
      isLoadingLogin = false;

      if (e.code == 'user-not-found') {
        emit(LoginError(error: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginError(error: 'Wrong password'));
      } else {
        emit(LoginError(error: e.message ?? 'Unknown error occurred'));
      }
    } catch (e) {
      isLoadingLogin = false;
      emit(LoginError(error: e.toString()));
    }
  }

  bool isShowLoginPassword = false;
  void changeLoginPasswordVisibility() {
    isShowLoginPassword = !isShowLoginPassword;
    emit(ShowPasswordInLogin());
  }

}

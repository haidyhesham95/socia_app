import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgram/auth/login/manager/login_cubit.dart';
import 'package:instgram/auth/login/view/auth_wrapper.dart';
import 'package:instgram/auth/register/view/mobile_register.dart';
import 'package:instgram/mobile_screen/features/mobile_home/manager/home_cubit.dart';
import 'package:instgram/mobile_screen/features/mobile_post/manager/post_cubit.dart';
import 'package:instgram/mobile_screen/features/mobile_search/model/search_cubit.dart';
import 'package:instgram/responsive/responsive_screen.dart';
import 'package:provider/provider.dart';

import 'auth/login/view/mobile_login.dart';
import 'auth/register/view/manager/register_cubit.dart';
import 'firebase_options.dart';
import 'mobile_screen/features/mobile_profile/view/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAQ7F6J03VZSyVtn-dRqfPAD_oBnbbE-zw",
            authDomain: "instgram-4eed9.firebaseapp.com",
            projectId: "instgram-4eed9",
            storageBucket: "instgram-4eed9.appspot.com",
            messagingSenderId: "1088152695081",
          appId: "1:1088152695081:web:b6c38159fba003f1790738",
        //    measurementId: "G-FLT5FSDQEQ"
        ));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
          BlocProvider(create: (context) => PostCubit()..getProfileAndPosts()),
          BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => HomeCubit()..getUser()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        home:const AuthWrapper(),
        routes: {
          '/register': (context) => const MobileRegister(),
          '/login': (context) => const MobileLogin(),
          '/responsiveScreen': (context) => const ResponsiveScreen(),
          //'/CommentScreen'  : (context) => const CommentScreen(),
        }
      ),
    );
  }
}


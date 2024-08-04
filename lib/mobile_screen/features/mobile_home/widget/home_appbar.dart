import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/conversation.dart';

import '../../../../utless/style/colors.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    elevation: 0,

    // title: SvgPicture.asset(
    //   'assets/images/instagram.svg',
    //   height: 32,
    // ),
    title: const Text('Social App'),
    actions: [
      IconButton(
        iconSize: 25,
        color: AppColors.movv ,
        icon: const Icon(Icons.email_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConversationsScreen(),
            ),
          );
        },
      ),


    ],
  );
}
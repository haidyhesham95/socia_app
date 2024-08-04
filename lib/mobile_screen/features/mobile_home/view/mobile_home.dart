import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/home_appbar.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/home_body.dart';


class MobileHome extends StatelessWidget {
  const MobileHome({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  homeAppBar(context),
      body: const HomeBody(),

    );
  }
}

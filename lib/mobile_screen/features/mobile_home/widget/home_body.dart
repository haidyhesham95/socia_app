import 'package:flutter/cupertino.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/posts.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
 const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
        return Column(
          children: [
          const SizedBox(
            height: 20,),
             Posts(),
            const SizedBox(
              height: 30,
            ),
          ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_home/widget/home_body.dart';

class WebHome extends StatelessWidget {
  const WebHome({super.key});

  @override
  Widget build(BuildContext context) {
    final  size = MediaQuery.of(context).size;
    return Scaffold(
       body:  Container(
          margin:  EdgeInsets.symmetric(horizontal:size.width/5, vertical: 55),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: HomeBody(),
        )
    );
  }
}

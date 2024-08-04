import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_search/Mobile_search.dart';

import '../utless/style/colors.dart';
import 'features/mobile_favourite/mobile_favourite.dart';
import 'features/mobile_home/view/mobile_home.dart';
import 'features/mobile_post/mobile_post.dart';
import 'features/mobile_profile/view/mobile_profile.dart';



class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  MobileLayoutState createState() => MobileLayoutState();
}

class MobileLayoutState extends State<MobileLayout> {
  var currentIndex = 0;
  final List<Widget> _pages = [
    const MobileHome(),
    const MobileSearch(),
    const MobilePost(),
    const MobileFavourite(),
    MobileProfile(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 10, right: 10,),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .020),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0260,
                    left: size.width * .0260,
                  ),
                  width: size.width * .135,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: const BoxDecoration(
                    color: AppColors.mov,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                 // size: size.width * .076,
                 size: 30,
                  color: index == currentIndex
                      ? AppColors.movv
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .025),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_outlined,
  Icons.search,
    Icons.add_circle_outline,
    CupertinoIcons.heart,
    CupertinoIcons.person,
  ];
}

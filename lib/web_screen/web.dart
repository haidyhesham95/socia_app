import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:instgram/mobile_screen/features/mobile_search/Mobile_search.dart';
import 'package:instgram/web_screen/web_home/screen/web_home.dart';

import '../mobile_screen/features/mobile_favourite/mobile_favourite.dart';
import '../mobile_screen/features/mobile_home/view/mobile_home.dart';
import '../mobile_screen/features/mobile_post/mobile_post.dart';
import '../mobile_screen/features/mobile_profile/view/mobile_profile.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  navigateScreen(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const WebHome(),
     MobileSearch(),
    const MobilePost(),
    const MobileFavourite(),
     MobileProfile(
       uid: FirebaseAuth.instance.currentUser!.uid,
     ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/instagram.svg',
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            color: currentIndex == 0 ? Colors.black : Colors.grey,
            onPressed: () {
             navigateScreen(0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: currentIndex == 1 ? Colors.black : Colors.grey,
            onPressed: () {
              navigateScreen(1);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            color: currentIndex == 2 ? Colors.black : Colors.grey,
            onPressed: () {
              navigateScreen(2);

            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            color: currentIndex == 3 ? Colors.black : Colors.grey,
            onPressed: () {
              navigateScreen(3);

            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            color: currentIndex == 4 ? Colors.black : Colors.grey,
            onPressed: () {
              navigateScreen(4);

            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: _pages,
      ),


    );
  }
}

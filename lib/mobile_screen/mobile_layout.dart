import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram/mobile_screen/features/mobile_search/Mobile_search.dart';

import '../utless/style/colors.dart';
import 'features/mobile_favourite/mobile_favourite.dart';
import 'features/mobile_home/view/mobile_home.dart';
import 'features/mobile_post/mobile_post.dart';
import 'features/mobile_profile/view/mobile_profile.dart';

// class MobileLayout extends StatefulWidget {
//   const MobileLayout({super.key});
//
//   @override
//   State<MobileLayout> createState() => _MobileLayoutState();
// }
//
// class _MobileLayoutState extends State<MobileLayout> {
//   int _currentIndex = 0;
//
//   final List<Widget> _pages = [
//     const MobileHome(),
//     const MobileSearch(),
//     const MobilePost(),
//     const MobileFavourite(),
//     MobileProfile(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_currentIndex],
//       // floatingActionButton: FloatingActionButton(
//       //   backgroundColor: AppColors.movv.withOpacity(0.8),
//       //
//       //
//       //   // backgroundColor: _currentIndex == 2 ? AppColors.movv : Colors.white,
//       //   elevation: 4,
//       //   shape: const CircleBorder(),
//       //   onPressed: () {
//       //     setState(() {
//       //       _currentIndex = 2; // Navigate to the Post screen
//       //     });
//       //   },
//       //   child: const Icon(Icons.add, size: 28),
//       // ),
//       //
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//        // color: AppColors.mov.withOpacity(0.5),
//        // color: Colors.white,
//         elevation: 2,
//         clipBehavior: Clip.antiAlias,
//         shape: const CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildAnimatedIcon(0, Icons.home_outlined),
//               _buildAnimatedIcon(1, Icons.search),
//               _buildAnimatedIcon(2, Icons.add_circle_outline),
//               _buildAnimatedIcon(3, CupertinoIcons.heart),
//               _buildAnimatedIcon(4, CupertinoIcons.person),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedIcon(int index, IconData icon) {
//     bool isSelected = _currentIndex == index;
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       padding: EdgeInsets.only(bottom: isSelected ? 15 : 0),
//       child: IconButton(
//         iconSize: 30,
//         icon: Icon(icon, color: isSelected ? AppColors.movv : Colors.black),
//         onPressed: () {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }

class MobileLayout extends StatefulWidget {
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
        margin: EdgeInsets.only(bottom: 12, left: 10, right: 10,),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
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
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0260,
                    left: size.width * .0260,
                  ),
                  width: size.width * .135,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: BoxDecoration(
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
// class MobileLayout extends StatefulWidget {
//   @override
//   _MobileLayoutState createState() => _MobileLayoutState();
// }
//
// class _MobileLayoutState extends State<MobileLayout> {
//   int currentIndex = 0;
//
//   final List<Widget> _pages = [
//     const MobileHome(),
//     const MobileSearch(),
//     const MobilePost(),
//     const MobileFavourite(),
//     MobileProfile(
//       uid: FirebaseAuth.instance.currentUser!.uid,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     double height = 90;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // Display the selected page
//           _pages[currentIndex],
//
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: SizedBox(
//               width: size.width,
//               height: height,
//               child: Stack(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(size.width * .04),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(30),
//                       ),
//                     ),
//                   ),
//                   CustomPaint(
//                     size: Size(size.width, height),
//                     painter: MyPainter(),
//                   ),
//                   Center(
//                     child: SizedBox(
//                       width: size.width * .93,
//                       height: height,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           IconButton(
//                             icon: Icon(
//                               currentIndex == 0
//                                   ? Icons.home
//                                   : Icons.home_outlined,
//                               color: currentIndex == 0
//                                   ? AppColors.movv
//                                   : Colors.black38,
//                               size: 30,
//
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentIndex = 0;
//                               });
//                             },
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               currentIndex == 1
//                                   ? Icons.search
//                                   : Icons.search_rounded,
//                               color: currentIndex == 1
//                                   ? AppColors.movv
//                                   : Colors.black38,
//                               size: 30,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentIndex = 1;
//                               });
//                             },
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               currentIndex == 2
//                                   ? Icons.add_circle_outline
//                                   : Icons.add,
//                               color: currentIndex == 2
//                                   ? AppColors.movv
//                                   : Colors.black38,
//                               size: 30,
//
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentIndex = 2;
//                               });
//                             },
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               currentIndex == 3
//                                   ? Icons.favorite
//                                   : Icons.favorite_border_rounded,
//                               color: currentIndex == 3
//                                   ? AppColors.movv
//                                   : Colors.black38,
//                               size: 30,
//
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentIndex = 3;
//                               });
//                             },
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               currentIndex == 4
//                                   ? Icons.person
//                                   : Icons.person_outline_rounded,
//                               color: currentIndex == 4
//                                   ? AppColors.movv
//                                   : Colors.black38,
//                               size: 30,
//
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 currentIndex = 4;
//                               });
//                             },
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(size.width * .08, size.height * .21); // Start
//     path.quadraticBezierTo(size.width * .2, 0, size.width * .35, 0);
//     path.quadraticBezierTo(size.width * .6, 0, size.width * .65, 0);
//     path.quadraticBezierTo(
//         size.width * .8, 0, size.width * .92, size.height * .21);
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

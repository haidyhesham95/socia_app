import 'package:flutter/material.dart';

import '../mobile_screen/mobile_layout.dart';
import '../web_screen/web.dart';

class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({super.key});

  @override
  State<ResponsiveScreen> createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const Home();
      } else {
        return  MobileLayout();
      }
    });
  }
}

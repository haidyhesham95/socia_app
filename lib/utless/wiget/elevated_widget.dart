import 'package:flutter/material.dart';

import '../style/colors.dart';

ElevatedButton elevatedButton(
  Size size, BuildContext context,
    {required void Function()? onpressed , double horizontal=20, required String text , WidgetStateProperty<Color?>? backgroundColor , Color? textColor,  IconData? icon}) {
  return ElevatedButton.icon(
    onPressed: onpressed,
    label: Text(
      text,
      style: TextStyle(color: textColor ?? Colors.black.withOpacity(0.8), fontSize: 18),
    ),
    icon: icon == null ? null :  Icon(
      icon ,
      color: textColor ?? Colors.black,
      size: 25,
    ),
    style: ButtonStyle(
      backgroundColor: backgroundColor,
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(
          vertical: size.width > 600 ? 20 : 10,
          horizontal:horizontal,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      side: MaterialStateProperty.all(
        BorderSide(
          color: AppColors.movv.withOpacity(0.7),
          width: 1,
        ),
      ),
    ),
  );
}

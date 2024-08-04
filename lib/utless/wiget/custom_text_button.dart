import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/text.dart';


class  CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.data,
    required this.onPressed,
  });
 final String text;
 final String data;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: AppStyles.styleSemiBold20(context).copyWith(color: AppColors.ground)),
        InkWell(
          onTap: onPressed,
          child: Text(data, style: AppStyles.styleBold18(context).copyWith(color: AppColors.movv)
        )
        ),
      ],
    );
  }
}

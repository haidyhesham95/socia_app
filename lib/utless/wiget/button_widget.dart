
import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/text.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget( {
    super.key,
    this.onPressed,
    this.color,
    this.text,
    this.textColor = Colors.white,
    this.height,
    this.width,
    this.child,
    this.borderColor,
    this.hasElevation = false,
    this.loading = false,
    this.loadingColor,
    this.borderRadius = 24,
    this.fontStyle,
    this.decorationColor,
    this.margin,
    this.padding,
  }) : assert(child != null || text != null);
  final Function()? onPressed;
  final Color? color;
  final String? text;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? borderColor;
  final Color textColor;
  final bool hasElevation;
  final bool loading;
  final Color? loadingColor;
  final Color? decorationColor;
  final double borderRadius;
  final TextStyle? fontStyle;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: decorationColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (hasElevation)
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 3,
                spreadRadius: 0,
                color: Colors.black45,
              )
          ]),
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        color: loading ?    AppColors.movv  : color ??    AppColors.movv,
        disabledTextColor: Colors.red,
        minWidth: width ?? MediaQuery.sizeOf(context).width,
        height: height ?? 49,
        disabledColor: color ?? AppColors.movv ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: borderColor != null
              ? BorderSide(
            color: borderColor!,
          )
              : BorderSide.none,
        ),
        splashColor: color,
        focusColor: color,
        highlightColor: color,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
        child: loading
            ? SizedBox(
          width: width,
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              color: loadingColor ?? Colors.white,
            ),
          ),
        )
            : text != null
            ? Text(
          text!,
          style: fontStyle ??
              AppStyles.styleBold22(context)

        )
            : child,
      ),
    );
  }
}
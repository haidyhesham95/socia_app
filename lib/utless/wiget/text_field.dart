import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/colors.dart';
import '../style/text.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
        this.onChanged,
        this.maxLength,
        this.hint,
        this.leading,
        this.validator,
        this.enabled = true,
        this.controller,
        this.initialText,
        this.expands = false,
        this.height,
        this.errorText,
        this.trailingIcon,
        this.keyboardType,
        this.node,
        this.label,
        this.isPassword = false,
        this.hintStyle,
        this.color,
        this.onSubmitted,
        this.inputFormatters,
        this.labelStyle,
        this.autoFillHint,
        this.maxLines,
        this.onTap,
        this.isDense = false,
        this.borderRadius,
        this.enabledBorderColor,
        this.focusedBorderColor,
        this.hintColor,
        this.contentPadding,
        this.vertical,
        this.textInputAction,
        this.titlePadding,
        this.readOnly,
        this.titleStyle,
      this.errorMessage,
      });
  final double? vertical;
  final String? hint;
  final int? maxLength;
  final Widget? leading;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLines;
  final TextEditingController? controller;
  final String? initialText;
  final bool expands;
  final double? height;
  final String? errorText;
  final Widget? trailingIcon;
  final TextInputType? keyboardType;
  final FocusNode? node;
  final String? label;
  final bool isPassword;
  final TextStyle? hintStyle;
  final Color? color;
  final TextStyle? labelStyle;
  final TextStyle? titleStyle;
  final List<String>? autoFillHint;
  final VoidCallback? onTap;
  final bool isDense;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? hintColor;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? titlePadding;
  final bool? readOnly;
  final String? errorMessage;



  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: widget.titleStyle ??
                AppStyles.styleSemiBold20(context).copyWith(color: Colors.black),

          ),
        const SizedBox(height: 5),
        TextFormField(


          onTap: widget.onTap,
          onTapOutside: (v) {
            FocusScope.of(context).unfocus();
          },
          cursorHeight: 20,
          maxLength: widget.maxLength,
          autofillHints: widget.autoFillHint,
          key: widget.key,
          readOnly: widget.readOnly ?? false,
          onEditingComplete: () {
            widget.node?.unfocus();
            FocusScope.of(context).unfocus();
          },

          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: widget.onSubmitted,
          focusNode: widget.node,
          keyboardType: widget.keyboardType ??
              (widget.expands ? TextInputType.multiline : TextInputType.text),
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          obscureText: widget.isPassword,
          textAlignVertical: TextAlignVertical.top,
          textInputAction: widget.textInputAction,
          cursorColor: AppColors.navy,
          controller: widget.controller,
          initialValue: widget.initialText,

          onChanged: widget.onChanged,
          maxLines: widget.maxLines ?? (widget.expands ? null : 1),
          validator: widget.validator ??
                  (value) {
                if (value!.isEmpty) {
                  return widget.errorMessage;
                }
                return null;
              },
          decoration: InputDecoration(
            // contentPadding: widget.contentPadding ??
            //     EdgeInsetsDirectional.symmetric(
            //       horizontal: 20,
            //       vertical: widget.vertical ?? 20,
            //     ),
            isDense: widget.isDense,
            labelStyle: widget.labelStyle,
            counterText: "",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            fillColor: widget.color ?? Colors.white,
            // .withOpacity(0.2),
            filled: true,
            prefixIcon: widget.leading,
            suffixIcon: widget.trailingIcon != null
                ? Padding(
              padding: const EdgeInsets.all(15),
              child: widget.trailingIcon,
            )
                : null,
            hintText: widget.hint,
            hintStyle: widget.hintStyle ?? AppStyles.styleBold20(context),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ??
                    AppColors.movv,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
               color: widget.focusedBorderColor ??
                   AppColors.movv,

              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(
                color: widget.enabledBorderColor ??
                    AppColors.movv,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            errorStyle: const TextStyle(color: Colors.red),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            errorText: widget.errorText,
            hintMaxLines: 2,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
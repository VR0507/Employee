import 'package:flutter/material.dart';

import '../../utils/resources/color.dart';
import '../../utils/resources/sizes.dart';


class CustomTextField extends StatelessWidget {
  final String? hintText;
  final String? counterText;
  final int? maxLength;
  final int? maxLine;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final inputFormate;
  final bool? obsecure;
  final Color? textColor;
  final Color? fillColor;
  final bool? readOnly;
  final MouseCursor? mouse;
  final double? radius;
  final onSubmit;
  final onChanged;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.hintText,
    required this.controller,
    this.inputType,
    this.inputFormate,
    this.maxLength,
    this.obsecure,
    this.suffixIcon,
    this.textColor,
    this.fillColor,
    this.readOnly,
    this.mouse,
    this.radius,
    this.onSubmit,
    this.onChanged,
    this.focusNode, this.maxLine, this.counterText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLine??1,
      obscureText: obsecure ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: AppSizes.mediumSpace,right:AppSizes.mediumSpace,top: AppSizes.mediumSpace),
        hintText: hintText,
        // filled: true,
        // fillColor: fillColor ?? AppColors.whiteColor,
        counterText: counterText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.unFocusInputBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(radius ?? 10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.focusInputBorderColor, width: 1.5),
            borderRadius: BorderRadius.circular(radius ?? 10)),
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: textColor ?? AppColors.lightGrey,
            fontSize: AppSizes.fontSize15,
            ),
      ),
      inputFormatters: inputFormate,
      mouseCursor: mouse,
      onSubmitted: onSubmit,
    );
  }
}

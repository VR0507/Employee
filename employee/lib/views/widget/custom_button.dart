import 'package:flutter/material.dart';

import '../../../utils/resources/sizes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final onPressEvent;
  final Color btnColor;
  final Color textColor;
  final Widget? child;
  final FocusNode? focusNode;
  final bool? autofocus;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressEvent,
      required this.btnColor,
      required this.textColor,
      this.child,
      this.focusNode,
      this.autofocus,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Sizes.size50,
      child: ElevatedButton(
        autofocus: autofocus ?? false,
        focusNode: focusNode,
        onPressed: onPressEvent,
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) => btnColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: child ??
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.fontSize20,
                  ),
            ),
      ),
    );
  }
}

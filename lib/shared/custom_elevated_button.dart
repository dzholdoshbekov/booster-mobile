import 'package:booster/core/constants/style/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isActive;
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isActive,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width, height),
          backgroundColor: isActive
              ? CustomColors.primaryColor
              : CustomColors.secondaryColorDark,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        child: Center(
            child: Text(
          text,
          style: AppFonts.s16W400,
        )));
  }
}

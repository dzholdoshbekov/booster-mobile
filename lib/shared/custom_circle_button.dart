import 'package:booster/core/constants/style/style.dart';
import 'package:flutter/material.dart';

class CustomCircleButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isActive;
  const CustomCircleButton({super.key, required this.isActive, this.onPressed});

  @override
  State<CustomCircleButton> createState() => _CustomCircleButtonState();
}

class _CustomCircleButtonState extends State<CustomCircleButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: widget.isActive ? widget.onPressed : null,
      elevation: 0,
      fillColor:
          widget.isActive ? Colors.white : CustomColors.secondaryColorDark,
      shape: CircleBorder(
          side: BorderSide(
              width: 1,
              color: widget.isActive
                  ? CustomColors.primaryColor
                  : CustomColors.secondaryColorDark)),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.close,
          size: 20,
          weight: 10,
          color: widget.isActive ? CustomColors.primaryColor : Colors.white,
        ),
      ),
    );
  }
}

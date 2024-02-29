import 'package:booster/core/constants/style/style.dart';
import 'package:flutter/material.dart';

class CustomInputWithoutBackground extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final bool onlyHint;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextStyle textStyle;
  final TextStyle labelStyle;
  final void Function(String)? onChange;
  final void Function()? onTapOutside;

  const CustomInputWithoutBackground(
      {super.key,
      required this.focusNode,
      required this.controller,
      this.hintText,
      this.suffixIcon,
      required this.obscureText,
      this.validator,
      this.maxLines,
      this.onChange,
      required this.textStyle,
      required this.labelStyle,
      required this.onlyHint,
      this.onTapOutside});

  @override
  State<CustomInputWithoutBackground> createState() =>
      _CustomInputWithoutBackgroundState();
}

class _CustomInputWithoutBackgroundState
    extends State<CustomInputWithoutBackground> {
  bool isControllerEmpty = true;
  bool isFocused = false;

  @override
  void initState() {
    isControllerEmpty = widget.controller.text.isEmpty;

    widget.controller.addListener(() {
      setState(() {
        isControllerEmpty = widget.controller.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      onFocusChange: (value) {
        setState(() {
          if (value) {
            isFocused = value;
          } else {
            if (widget.controller.text.isEmpty) isFocused = false;
          }
        });
      },
      child: TextField(
        enabled: false,
        focusNode: widget.focusNode,
        maxLines: widget.maxLines,
        keyboardType: TextInputType.multiline,
        controller: widget.controller,
        style: widget.textStyle,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: CustomColors.secondaryTextColor),
            hintText: isFocused ? '' : widget.hintText,
            labelText: isControllerEmpty ? null : widget.hintText,
            alignLabelWithHint: true,
            labelStyle: widget.labelStyle,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.only(bottom: 0, left: 24, top: 5)),
        obscureText: widget.obscureText,
        onTapOutside: (event) {
          widget.focusNode.unfocus();
          if (widget.onTapOutside != null) widget.onTapOutside!();
        },
        onChanged: (value) {
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
      ),
    );
  }
}

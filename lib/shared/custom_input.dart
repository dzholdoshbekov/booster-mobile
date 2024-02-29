import 'package:booster/core/constants/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  final TextInputType textInputType;
  final FocusNode focusNode;
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? maxLines;
  final void Function(String)? onChange;
  final void Function()? isClearedUpdate;
  bool? isCleared;

  CustomInput({
    super.key,
    required this.focusNode,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    required this.obscureText,
    this.validator,
    this.maxLines,
    this.onChange,
    this.isCleared,
    required this.textInputType,
    this.isClearedUpdate,
    this.labelText,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late FocusScopeNode focusScopeNode;
  bool isControllerEmpty = true;
  bool isFocused = false;
  late bool isCleared;

  @override
  void didUpdateWidget(CustomInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('changed');
    print(widget.isCleared != oldWidget.isCleared && widget.isCleared!);

    if (widget.isCleared != oldWidget.isCleared && widget.isCleared!) {
      print('proshel');
      if (widget.isClearedUpdate != null) widget.isClearedUpdate!();
      setState(() {
        isFocused = !(widget.isCleared ?? false);
        isControllerEmpty = true;
        print(widget.isCleared);
      });
    }
  }

  @override
  void initState() {
    focusScopeNode = FocusScopeNode();

    isControllerEmpty = widget.controller.text.isEmpty;

    isFocused = widget.controller.text.isNotEmpty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.secondaryColor),
        color: isControllerEmpty || !isFocused
            ? CustomColors.secondaryColor
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FocusScope(
          node: focusScopeNode,
          onFocusChange: (value) {
            setState(() {
              if (value) {
                isFocused = value;
              } else {
                if (isControllerEmpty) isFocused = false;
              }
            });
          },
          child: TextField(
            maxLines: widget.maxLines,
            keyboardType: widget.textInputType,
            controller: widget.controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: isFocused ? "" : widget.hintText,
                labelText: isFocused ? widget.labelText : null,
                alignLabelWithHint: true,
                labelStyle: AppFonts.s16W400.copyWith(
                  color: CustomColors.secondaryTextColor,
                ),
                suffixIcon: widget.suffixIcon,
                contentPadding:
                    const EdgeInsets.only(bottom: 0, left: 24, top: 5)),
            obscureText: widget.obscureText,
            onTapOutside: (event) {
              focusScopeNode.unfocus();
            },
            onChanged: (value) {
              setState(() {
                isControllerEmpty = widget.controller.text.isEmpty;
              });

              if (widget.onChange != null) {
                print('object');
                widget.onChange!(value);
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:booster/core/constants/style/style.dart';
import 'package:booster/shared/custom_input_without_backgroung.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final List<String> productTypes;
  final void Function(String) onFilter;
  final void Function(String, String)? onChange;

  const CustomDropDownMenu(
      {super.key,
      this.onChange,
      required this.onFilter,
      required this.focusNode,
      required this.controller,
      required this.hintText,
      required this.productTypes,
      this.labelText});

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  final layerLink = LayerLink();
  bool isOpen = false;
  OverlayEntry? entry;
  String? selectedProductType;
  String? previousProductType;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => showOverlay());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width - 4,
          child: CompositedTransformFollower(
              link: layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height - 6),
              child: buildOverlay())),
    );
    overlay.insert(entry!);
  }

  Widget buildOverlay() => Material(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: CustomColors.blackorigin),
          // margin: const EdgeInsets.all(0),

          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.productTypes.length,
            itemBuilder: (context, int index) {
              return ListTile(
                visualDensity: const VisualDensity(vertical: -3),
                title: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.productTypes[index],
                    style: AppFonts.s16W400.copyWith(color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (widget.controller.text.isNotEmpty) {
                      previousProductType = widget.controller.text;
                    }

                    widget.onFilter(widget.controller.text);

                    widget.controller.text = widget.productTypes[index];

                    // isOpen = !isOpen;
                  });

                  if (widget.onChange != null) {
                    widget.onChange!(
                        widget.productTypes[index], previousProductType!);
                  }
                },
              );
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: AnimatedCrossFade(
        crossFadeState:
            isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 5),
        firstChild: Container(
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.secondaryColor),
            borderRadius: BorderRadius.circular(16.0),
            color: widget.controller.text.isEmpty
                ? CustomColors.secondaryColor
                : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 20),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomInputWithoutBackground(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      obscureText: false,
                      onlyHint: false,
                      hintText: widget.controller.text.isEmpty
                          ? '${widget.hintText}*'
                          : widget.hintText,
                      textStyle: AppFonts.s16W400.copyWith(color: Colors.black),
                      labelStyle: AppFonts.s16W400
                          .copyWith(color: CustomColors.secondaryTextColor),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            print('222');
                            if (isOpen == false) {
                              showOverlay();
                            }

                            isOpen = !isOpen;
                          });
                        },
                        child: const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
        secondChild: CompositedTransformTarget(
          link: layerLink,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: CustomColors.blackorigin,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomInputWithoutBackground(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      onTapOutside: () {
                        setState(() {
                          if (isOpen) isOpen = false;
                        });
                      },
                      obscureText: false,
                      onlyHint: false,
                      hintText: widget.controller.text.isEmpty
                          ? '${widget.hintText}*'
                          : widget.hintText,
                      textStyle: AppFonts.s16W400.copyWith(color: Colors.white),
                      labelStyle: AppFonts.s16W400.copyWith(
                          color: widget.controller.text.isEmpty
                              ? Colors.white
                              : CustomColors.blackorigin),
                    ),
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        Icons.arrow_drop_up,
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

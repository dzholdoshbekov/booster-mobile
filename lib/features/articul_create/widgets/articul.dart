import 'package:booster/core/constants/style/style.dart';
import 'package:booster/shared/custom_input.dart';
import 'package:flutter/material.dart';

class Articul extends StatefulWidget {
  const Articul({super.key});

  @override
  State<Articul> createState() => _ArticulState();
}

class _ArticulState extends State<Articul> {
  late TextEditingController articulNameTextController;
  late TextEditingController articulDescriptionConroller;

  late FocusNode articulNameFocusNode;
  late FocusNode articulDescriptionFocusNode;

  @override
  void initState() {
    articulNameTextController = TextEditingController();
    articulNameFocusNode = FocusNode();

    articulDescriptionConroller = TextEditingController();
    articulDescriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    articulDescriptionConroller.dispose();
    articulDescriptionFocusNode.dispose();

    articulNameTextController.dispose();
    articulNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            "ИНФОРМАЦИЯ ОБ АРТИКУЛЕ",
            style: AppFonts.s16W500,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomInput(
            textInputType: TextInputType.multiline,
            focusNode: articulNameFocusNode,
            controller: articulNameTextController,
            hintText: 'Номер артикула*',
            obscureText: false,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomInput(
            textInputType: TextInputType.multiline,
            focusNode: articulDescriptionFocusNode,
            controller: articulDescriptionConroller,
            obscureText: false,
            hintText: 'Описание артикула',
            maxLines: 4,
          )
        ],
      ),
    );
  }
}

import 'package:booster/features/articul_create/view/articul_create_screen.dart';
import 'package:booster/shared/custom_circle_button.dart';
import 'package:booster/shared/custom_dropdown_menu.dart';
import 'package:booster/shared/custom_input.dart';
import 'package:flutter/material.dart';

class MaterialObject extends StatefulWidget {
  final MaterialModel material;
  final List<String> selectedProductTypes;
  final Function(MaterialModel) onUpdateMaterial;
  final Function(MaterialModel) onRemoveMaterial;

  const MaterialObject(
      {super.key,
      required this.material,
      required this.selectedProductTypes,
      required this.onUpdateMaterial,
      required this.onRemoveMaterial});

  @override
  State<MaterialObject> createState() => _MaterialObjectState();
}

class _MaterialObjectState extends State<MaterialObject> {
  late TextEditingController materialNameTextController;
  late FocusNode materialNameFocusNode;

  late TextEditingController amountTextController;
  late FocusNode amountFocusNode;

  late TextEditingController unitTextController;
  late FocusNode unitFocusNode;

  List<String> productTypes = PRODUCT_TYPE_OPTIONS;

  @override
  void initState() {
    materialNameFocusNode = FocusNode();
    materialNameTextController =
        TextEditingController(text: widget.material.title);

    amountFocusNode = FocusNode();
    amountTextController =
        TextEditingController(text: widget.material.amount.toString());

    unitFocusNode = FocusNode();
    unitTextController = TextEditingController(text: widget.material.unit);

    super.initState();
  }

  @override
  void dispose() {
    materialNameFocusNode.dispose();
    materialNameTextController.dispose();

    amountFocusNode.dispose();
    amountTextController.dispose();

    unitFocusNode.dispose();
    unitTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: CustomInput(
                  textInputType: TextInputType.multiline,
                  focusNode: materialNameFocusNode,
                  controller: materialNameTextController,
                  onChange: (value) {
                    widget.material.title = value;

                    widget.onUpdateMaterial(widget.material);
                  },
                  obscureText: false,
                  hintText: "Материал, цвет*",
                  labelText: 'Материал,цвет',
                ),
              ),
              CustomCircleButton(
                isActive: materialNameTextController.text.isNotEmpty,
                onPressed: () {
                  widget.onRemoveMaterial(widget.material);
                },
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CustomInput(
                      textInputType: TextInputType.number,
                      focusNode: amountFocusNode,
                      controller: amountTextController,
                      onChange: (value) {
                        try {
                          widget.material.amount = int.parse(value);
                        } on FormatException {
                          widget.material.amount = 0;
                        }
                        widget.onUpdateMaterial(widget.material);
                      },
                      obscureText: false,
                      hintText: 'кол-во на ед продукта*',
                      labelText: 'кол-во на ед продукта',
                    ),
                  ),
                ),
                Expanded(
                  child: CustomDropDownMenu(
                      productTypes: productTypes
                          .where(
                              (element) => element != unitTextController.text)
                          .toList(),
                      hintText: 'ед. измерения',
                      focusNode: unitFocusNode,
                      onFilter: (currentUnit) {
                        setState(() {
                          productTypes = PRODUCT_TYPE_OPTIONS;
                        });
                      },
                      onChange: (selected, previous) {
                        widget.onUpdateMaterial(widget.material);
                      },
                      controller: unitTextController),
                )
              ]),
        ],
      ),
    );
  }
}

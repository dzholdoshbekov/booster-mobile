import 'package:booster/features/articul_create/view/articul_create_screen.dart';
import 'package:booster/shared/custom_circle_button.dart';
import 'package:booster/shared/custom_dropdown_menu.dart';
import 'package:booster/shared/custom_elevated_button.dart';
import 'package:booster/shared/custom_input.dart';
import 'package:flutter/material.dart';

class MaterialWidget extends StatefulWidget {
  final List<MaterialModel> materials;
  final Function(List<MaterialModel>) onAddMaterial;

  const MaterialWidget({
    super.key,
    required this.materials,
    required this.onAddMaterial,
  });

  @override
  State<MaterialWidget> createState() => _MaterialWidgetState();
}

class _MaterialWidgetState extends State<MaterialWidget> {
  late TextEditingController materialNameTextController;
  late FocusNode materialNameFocusNode;

  late TextEditingController amountTextController;
  late FocusNode amountFocusNode;

  late TextEditingController unitTextController;
  late FocusNode unitFocusNode;

  List<String> productTypes = PRODUCT_TYPE_OPTIONS;

  bool isCleared = false;

  @override
  void initState() {
    materialNameFocusNode = FocusNode();
    materialNameTextController = TextEditingController();

    amountFocusNode = FocusNode();
    amountTextController = TextEditingController();

    unitFocusNode = FocusNode();
    unitTextController = TextEditingController();

    materialNameTextController.addListener(() {
      setState(() {});
    });

    amountTextController.addListener(() {
      setState(() {});
    });
    filterProductTypes();
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

  void filterProductTypes() {
    List<String> selectedProductTypes =
        widget.materials.map((material) => material.unit).toList();

    selectedProductTypes.map((productType) =>
        productTypes.removeWhere((element) => productType == element));
  }

  void handlePress() {
    MaterialModel newMaterial = MaterialModel(materialNameTextController.text,
        int.parse(amountTextController.text), unitTextController.text);

    widget.materials.add(newMaterial);

    widget.onAddMaterial(widget.materials);

    materialNameTextController.clear();
    amountTextController.clear();
    unitTextController.clear();

    setState(() {
      isCleared = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                  isCleared: isCleared,
                  isClearedUpdate: () {
                    isCleared = false;
                  },
                  obscureText: false,
                  hintText: "Материал, цвет*",
                  labelText: "Материал, цвет",
                ),
              ),
              CustomCircleButton(
                isActive: materialNameTextController.text.isNotEmpty,
                onPressed: () {
                  materialNameTextController.clear();
                  unitTextController.clear();
                  amountTextController.clear();

                  setState(() {
                    isCleared = true;
                  });
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
                      isCleared: isCleared,
                      obscureText: false,
                      hintText: 'кол-во на ед. продукта*',
                      labelText: 'кол-во на ед.продукта',
                    ),
                  ),
                ),
                Expanded(
                  child: CustomDropDownMenu(
                    productTypes: productTypes
                        .where((element) => element != unitTextController.text)
                        .toList(),
                    hintText: 'ед. измерения',
                    focusNode: unitFocusNode,
                    controller: unitTextController,
                    onFilter: (currentUnit) {
                      setState(() {
                        productTypes = PRODUCT_TYPE_OPTIONS;
                      });
                    },
                  ),
                )
              ]),
          const SizedBox(
            height: 8,
          ),
          CustomButton(
            text: '+материал',
            onPressed: handlePress,
            height: 50,
            width: 195,
            isActive: materialNameTextController.text.isNotEmpty &&
                amountTextController.text.isNotEmpty &&
                unitTextController.text.isNotEmpty,
          )
        ],
      ),
    );
  }
}

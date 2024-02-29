import 'package:booster/features/articul_create/view/articul_create_screen.dart';
import 'package:booster/shared/custom_circle_button.dart';
import 'package:booster/shared/custom_dropdown_menu.dart';
import 'package:booster/shared/custom_elevated_button.dart';
import 'package:booster/shared/custom_input.dart';
import 'package:flutter/material.dart';

class AccessoriesWidget extends StatefulWidget {
  final List<MaterialModel> accessory;
  final Function(List<MaterialModel>) onAddAccessory;

  const AccessoriesWidget(
      {super.key, required this.accessory, required this.onAddAccessory});

  @override
  State<AccessoriesWidget> createState() => _AccessoriesWidgetState();
}

class _AccessoriesWidgetState extends State<AccessoriesWidget> {
  late TextEditingController accessoryNameTextController;
  late FocusNode accessoryNameFocusNode;

  late TextEditingController amountTextController;
  late FocusNode amountFocusNode;

  late TextEditingController unitTextController;
  late FocusNode unitFocusNode;

  List<String> productTypes = PRODUCT_TYPE_OPTIONS;

  bool isCleared = false;

  @override
  void initState() {
    accessoryNameFocusNode = FocusNode();
    accessoryNameTextController = TextEditingController();

    amountFocusNode = FocusNode();
    amountTextController = TextEditingController();

    unitFocusNode = FocusNode();
    unitTextController = TextEditingController();

    accessoryNameTextController.addListener(() {
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
    accessoryNameFocusNode.dispose();
    accessoryNameTextController.dispose();

    amountFocusNode.dispose();
    amountTextController.dispose();

    unitFocusNode.dispose();
    unitTextController.dispose();
    super.dispose();
  }

  void filterProductTypes() {
    List<String> selectedProductTypes =
        widget.accessory.map((material) => material.unit).toList();

    selectedProductTypes.map((productType) =>
        productTypes.removeWhere((element) => productType == element));
  }

  void handlePress() {
    MaterialModel newAccessory = MaterialModel(accessoryNameTextController.text,
        int.parse(amountTextController.text), unitTextController.text);

    widget.accessory.add(newAccessory);

    widget.onAddAccessory(widget.accessory);

    accessoryNameTextController.clear();
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
                  focusNode: accessoryNameFocusNode,
                  controller: accessoryNameTextController,
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
                isActive: accessoryNameTextController.text.isNotEmpty,
                onPressed: () {
                  accessoryNameTextController.clear();
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
            text: '+фурнитура',
            onPressed: handlePress,
            width: 195,
            height: 50,
            isActive: accessoryNameTextController.text.isNotEmpty &&
                amountTextController.text.isNotEmpty &&
                unitTextController.text.isNotEmpty,
          )
        ],
      ),
    );
  }
}

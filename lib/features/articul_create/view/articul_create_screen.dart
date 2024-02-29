import 'package:booster/core/constants/style/style.dart';
import 'package:booster/features/articul_create/widgets/accessories.dart';
import 'package:booster/features/articul_create/widgets/articul.dart';
import 'package:booster/features/articul_create/widgets/header.dart';
import 'package:booster/features/articul_create/widgets/material.dart';
import 'package:booster/features/articul_create/widgets/material_object.dart';
import 'package:booster/shared/custom_elevated_button.dart';
import 'package:flutter/material.dart';

const List<String> PRODUCT_TYPE_OPTIONS = ["метр", "рулон", "штука"];

class MaterialModel {
  String title;
  int amount;
  String unit;

  MaterialModel(this.title, this.amount, this.unit);
}

class ArticulCreateScreen extends StatefulWidget {
  const ArticulCreateScreen({super.key});

  @override
  State<ArticulCreateScreen> createState() => _ArticulCreateScreenState();
}

class _ArticulCreateScreenState extends State<ArticulCreateScreen> {
  List<MaterialModel> materials = [];
  List<MaterialModel> accessories = [];

  bool requiredFieldsCheck() {
    bool isOk = materials.every((material) =>
        material.amount != 0 &&
        material.title.isNotEmpty &&
        material.unit.isNotEmpty);
    print(isOk);
    return isOk;
  }

  List<Widget> getMaterials() {
    return materials
        .map((material) => MaterialObject(
              material: material,
              selectedProductTypes:
                  materials.map((material) => material.unit).toList(),
              onUpdateMaterial: (material) {
                setState(() {
                  MaterialModel existingMaterial = materials
                      .firstWhere((element) => material.title == element.title);

                  existingMaterial = material;

                  materials[materials.indexOf(existingMaterial)] = material;
                });
              },
              onRemoveMaterial: (material) {
                setState(() {
                  MaterialModel existingMaterial = materials
                      .firstWhere((element) => material.title == element.title);
                  existingMaterial = material;
                  materials.remove(existingMaterial);
                });
              },
            ))
        .toList();
  }

  List<Widget> getAccessory() {
    return accessories
        .map((material) => MaterialObject(
              material: material,
              selectedProductTypes:
                  accessories.map((material) => material.unit).toList(),
              onUpdateMaterial: (material) {
                setState(() {
                  MaterialModel existingMaterial = accessories
                      .firstWhere((element) => material.title == element.title);

                  existingMaterial = material;

                  accessories[accessories.indexOf(existingMaterial)] = material;
                });
              },
              onRemoveMaterial: (material) {
                setState(() {
                  MaterialModel existingMaterial = accessories
                      .firstWhere((element) => material.title == element.title);
                  existingMaterial = material;
                  accessories.remove(existingMaterial);
                });
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(),
            const Articul(),
            const SizedBox(
              height: 8,
            ),
            Text(
              "МАТЕРИАЛ",
              style: AppFonts.s16W500,
            ),
            const SizedBox(
              height: 8,
            ),
            ...getMaterials(),
            MaterialWidget(
              materials: materials,
              onAddMaterial: (materials) {
                setState(() {
                  this.materials = materials;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "ФУРНИТУРА",
              style: AppFonts.s16W500,
            ),
            const SizedBox(
              height: 8,
            ),
            ...getAccessory(),
            AccessoriesWidget(
              accessory: accessories,
              onAddAccessory: (accessories) {
                setState(() {
                  this.accessories = accessories;
                  print(this.accessories.first);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 66, bottom: 166, left: 16, right: 16),
              child: CustomButton(
                  text: 'Сохранить',
                  onPressed: () {},
                  isActive: requiredFieldsCheck(),
                  height: 50,
                  width: double.infinity),
            )
          ],
        ),
      ),
    ));
  }
}

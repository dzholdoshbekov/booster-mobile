import 'package:booster/core/constants/style/style.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 27, top: 56, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Booster',
            style: AppFonts.s24W700,
          ),
          const Image(
            image: AssetImage(
              'assets/logo.png',
            ),
            height: 28,
            width: 28,
          )
        ],
      ),
    );
  }
}

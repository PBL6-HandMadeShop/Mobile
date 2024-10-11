import 'package:HandcraftShop/src/feature/dashboard/model/rive_asset.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenuTitle extends StatelessWidget {
  const SideMenuTitle({
    required this.menu,
    required this.press,
    required this.riveOnInit,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Color(0xFFE6E6E6),
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isSelected ? 288 : 0,
              left: 10, // Ensure it starts from the left edge
              child: Container(
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF8B4819),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(menu.title, style: TextStyle(color: Colors.white)!.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              )),
            ),
          ],
        ),
      ],
    );
  }
}
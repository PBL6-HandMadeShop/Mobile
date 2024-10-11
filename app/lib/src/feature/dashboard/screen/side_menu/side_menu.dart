import 'package:HandcraftShop/src/feature/dashboard/model/rive_asset.dart';
import 'package:HandcraftShop/src/feature/dashboard/screen/side_menu/side_menu_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../../constants/colors.dart';
import '../../../../utils/rive/rive_utils.dart';
import 'infor_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Close the side menu
            },
            child: Container(
              color: Colors.transparent, // Transparent container to detect taps
            ),
          ),
          Container(
            width: 288,
            height: double.infinity,
            color: appBarColor,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InfoCard(name: 'Name', level: 'Level'),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      "Browse".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70),
                    ),
                  ), //BROWSE
                  // Render menu items
                  ...sideMenus.map((menu) => SideMenuTitle(
                    menu: menu,
                    press: () {
                      setState(() {
                        selectedMenu = menu;
                      });
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                    },
                    riveOnInit: (artboard) {
                      StateMachineController controller =
                      RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    isSelected: selectedMenu ==
                        menu, // Check if this is the selected menu
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      "History".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70),
                    ),
                  ), //HISTOTRY\
                  ...sideMenu2.map((menu) => SideMenuTitle(
                    menu: menu,
                    press: () {
                      setState(() {
                        selectedMenu = menu;
                      });
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                    },
                    riveOnInit: (artboard) {
                      StateMachineController controller =
                      RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    isSelected: selectedMenu ==
                        menu, // Check if this is the selected menu
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                    child: Text(
                      "Settings".toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white70),
                    ),
                  ), //Settings
                  ...sideMenu3.map((menu) => SideMenuTitle(
                    menu: menu,
                    press: () {
                      setState(() {
                        selectedMenu = menu;
                      });
                      menu.input!.change(true);
                      Future.delayed(Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                    },
                    riveOnInit: (artboard) {
                      StateMachineController controller =
                      RiveUtils.getRiveController(
                        artboard,
                        stateMachineName: menu.stateMachineName,
                      );
                      menu.input = controller.findSMI("active") as SMIBool;
                    },
                    isSelected: selectedMenu ==
                        menu, // Check if this is the selected menu
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
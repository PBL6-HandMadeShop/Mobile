import 'package:HandcraftShop/src/constants/colors.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:HandcraftShop/src/feature/dashboard/screen/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottomWidget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final txttheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Get.to(() => const SideMenu());
            },
          ),
        ),
        title: Text(
          appName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        elevation: 0,

        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: cardBgColor),
            child: IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
              onPressed: () {

              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //headling
              Text(dashboardTitle, style: txttheme.bodyMedium),
              Text(
                dashboardSubtitle,
                style: txttheme.headlineLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              //searchBox
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 4)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dashboardSearch,
                      style: txttheme.bodyMedium
                          ?.apply(color: Colors.grey.withOpacity(0.5)),
                    ),
                    const Icon(
                      Icons.mic,
                      size: 25,
                    ),
                  ],
                ),
              ),
              //Categories
              SizedBox(
                width: 170,
                height: 100,
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: blackColor),
                      child: Center(
                        child: Text(
                          'DS',
                          style:
                              txttheme.displaySmall?.apply(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do Su",
                            style: txttheme.headlineLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "thu cong",
                            style: txttheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomWidget(),
    );
  }
}


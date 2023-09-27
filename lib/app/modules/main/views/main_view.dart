import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tit/app/modules/home/views/home_view.dart';
import 'package:tit/app/modules/main/views/pages/people_page.dart';
import 'package:tit/app/modules/main/views/pages/settings_page.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  MainView({Key? key}) : super(key: key);

  final List<Widget> pages = [
    Container(),
    PeoplePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.onPageChanged,
          selectedIndex: controller.index,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.message),
              icon: Icon(Icons.message_outlined),
              label: 'Chat',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.group),
              icon: Icon(Icons.group_outlined),
              label: 'People',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

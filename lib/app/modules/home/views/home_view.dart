import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit/app/core/src/app_size.dart';
import 'package:tit/app/core/src/app_spacing.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSize.s),
          child: Text(
            "V 1.0.1",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: Icon(Icons.qr_code))
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.userEntity == null
              ? Container()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: Get.height * 0.25,
                          padding: EdgeInsets.only(top: AppSpacing.xl.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                height: 90,
                                width: 90,
                                child: ClipOval(
                                    child: Image.network(
                                  errorBuilder: (context, _, stackTrac) {
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SvgPicture.asset(
                                        'assets/svg/logo.svg',
                                      ),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey,
                                      height: 90,
                                      width: 90,
                                    );
                                  },
                                  controller.userEntity?.photoUrl ?? "",
                                  height: 90,
                                  width: 90,
                                )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                controller.userEntity?.displayName ?? "User",
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon((Icons.dark_mode)),
                          title: Text("Dark Mode"),
                          trailing: Switch(
                            value: controller.state.isDarkMode,
                            onChanged: controller.onDarkModeChange,
                          ),
                        ),
                        ListTile(
                          leading: Icon((Icons.notifications)),
                          title: Text("Notifaction"),
                          trailing: Switch(
                            value: controller.state.isNotificationOn,
                            onChanged: controller.onNotificationStateChange,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('About'),
                        ),
                        ListTile(
                          onTap: showLogoutDialog,
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Logout'),
                        ),
                      ]),
                ),
        ),
      ),
    );
  }

  void showLogoutDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text("Logout"),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    controller.onLogout();
                  },
                  child: const Text("Okay")),
            ],
          );
        });
  }
}

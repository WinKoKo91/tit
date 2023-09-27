import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:tit/app/core/src/app_size.dart';
import 'package:tit/app/core/src/app_spacing.dart';
import 'package:tit/app/routes/app_pages.dart';

import '../../../../widgets/profile_image_widget.dart';
import '../../../home/controllers/home_controller.dart';

class SettingsPage extends GetView<HomeController> {
  const SettingsPage({Key? key}) : super(key: key);

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
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.EDIT_PROFILE, arguments: controller.userEntity);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.QR_SCANNER);
              },
              icon: Icon(Icons.qr_code))
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.userEntity == null
              ? Container()
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: Get.height * 0.23,
                          padding: EdgeInsets.only(top: AppSpacing.xl.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProfileImageWidget( url:  controller.userEntity!.photoUrl??""),
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
                        Divider(
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(
                          height: AppSpacing.x2l.h,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          leading: Icon((Icons.dark_mode)),
                          title: Text("Dark Mode"),
                          trailing: Switch.adaptive(
                            value: controller.state.isDarkMode,
                            onChanged: controller.onDarkModeChange,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          leading: Icon((Icons.notifications)),
                          title: Text("Notifaction"),
                          trailing: Switch.adaptive(
                            value: controller.state.isNotificationOn,
                            onChanged: controller.onNotificationStateChange,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          leading: Icon(Icons.info),
                          title: Text('About'),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
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

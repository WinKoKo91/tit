import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: controller.logout, icon: Icon(Icons.logout))
        ],
      ),
      body: Obx(
        () => controller.user == null
            ? Container()
            : SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey,
                              height: 90,
                              width: 90,
                            );
                          },
                          controller.user?.photoUrl ?? "",
                          height: 90,
                          width: 90,
                        )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        controller.user?.displayName ?? "",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ]),
              ),
      ),
    );
  }
}

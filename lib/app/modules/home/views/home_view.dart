import 'package:flutter/material.dart';

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
          IconButton(onPressed: controller.logout, icon: Icon( Icons.logout))
        ],
      ),
      body:  Center(
        child: Text(
          controller.user.displayName??"",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

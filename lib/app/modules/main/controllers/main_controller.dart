import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late PageController pageController;

  final _index = 0.obs;

  get index => _index.value;

  set index(value) {
    _index.value = value;
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }




  void onPageChanged(int value) {
    index =value;
    pageController.jumpToPage(value);
  }
}

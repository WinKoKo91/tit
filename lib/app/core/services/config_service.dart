import 'dart:ui';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';

class ConfigService extends GetxService {
  static ConfigService get to => Get.find<ConfigService>();
  final PreferenceManager _preferenceManager =
      Get.find(tag: (PreferenceManager).toString());
  Locale selectedLocale = Locale('en', 'US');
  List<Locale> languages = const [
    Locale('en', 'US'),
    Locale('mm', 'MY'),
  ];

  bool isFirstTimeOpen = true;

  PackageInfo? _packageInfo;

  late String version;

  @override
  void onInit() async {
    _packageInfo = await PackageInfo.fromPlatform();

    isFirstTimeOpen = await _preferenceManager.getBool(AppKey.firstTimeOpen,
        defaultValue: true);

    super.onInit();
  }

  Future<bool> saveFirstTimeOpen() async {
    return await _preferenceManager.setBool(AppKey.firstTimeOpen, false);
  }

  void onInitLocale() async {
    String languageCode = await _preferenceManager
        .getString(AppKey.languageCode, defaultValue: "");

    if (languageCode.isEmpty) {
      return null;
    }

    selectedLocale =
        languages.firstWhere((element) => languageCode == element.languageCode);
  }
}

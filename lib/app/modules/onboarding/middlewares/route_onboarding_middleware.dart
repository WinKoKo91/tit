import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth_service.dart';
import 'package:tit/app/core/services/config_service.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/routes/app_pages.dart';

class RouteWelcomeMiddleware extends GetMiddleware {


  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});



  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    final PreferenceManager _preferenceManager = Get.find<PreferenceManager>();
    bool isFirstTimeOpen = await _preferenceManager
        .getBool(AppKey.firstTimeOpen, defaultValue: true);

    if (isFirstTimeOpen) {
      return null;
    } else {
      return Get.rootDelegate.toNamed(Routes.LOGIN);
    }
  }
}

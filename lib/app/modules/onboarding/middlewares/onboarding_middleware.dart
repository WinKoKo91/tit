import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tit/app/core/constants/app_keys.dart';
import 'package:tit/app/core/services/auth/auth_service.dart';
import 'package:tit/app/core/services/config_service.dart';
import 'package:tit/app/data/local/preference/preference_manager.dart';
import 'package:tit/app/routes/app_pages.dart';

class OnboardingMiddleware extends GetMiddleware {
  OnboardingMiddleware({required int priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    bool isFirstTimeOpen = ConfigService.to.isFirstTimeOpen;
    return isFirstTimeOpen ? null : const RouteSettings(name: Routes.LOGIN);
  }
}
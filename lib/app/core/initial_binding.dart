import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tit_ti_too/app/core/services/config_service.dart';

import '../data/local/preference/preference_manager.dart';
import '../data/local/preference/preference_manager_impl.dart';

class InitialBinding extends Bindings{

  @override
  void dependencies() {

      Get.lazyPut<PreferenceManager>(
            () => PreferenceManagerImpl(),
        tag: (PreferenceManager).toString(),
        fenix: true,
      );
      Get.put<ConfigService>(ConfigService());
  }

}
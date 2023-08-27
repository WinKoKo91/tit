import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tit/app/core/services/config_service.dart';
import 'package:tit/app/data/repositories/user_repository_impl.dart';

import '../data/local/preference/preference_manager.dart';
import '../data/local/preference/preference_manager_impl.dart';
import '../data/repositories/user_repository.dart';
import 'services/auth/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );
    Get.put<ConfigService>(ConfigService());
    Get.put<AuthService>(AuthService());
    Get.put<UserRepository>(UserRepositoryImpl());
  }
}

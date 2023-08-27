import 'package:get/get.dart';
import 'package:tit/app/modules/splash/bindings/splash_binding.dart';
import 'package:tit/app/modules/splash/middlewares/onboarding_middleware.dart';
import 'package:tit/app/modules/splash/views/splash_view.dart';

import '../core/middleware/auth_middleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/middlewares/onboarding_middleware.dart';
import '../modules/onboarding/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      middlewares: [
        OnboardingMiddleware(priority: 1),
      ],
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => const LoginView(),
        binding: LoginBinding(),
        middlewares: [AuthMiddleware(priority: 1)]),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}

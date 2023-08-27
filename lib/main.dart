import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tit/firebase_options.dart';

import 'app/core/initial_binding.dart';
import 'app/core/services/config_service.dart';
import 'app/core/theme/app_theme.dart';
import 'app/data/local/preference/preference_manager.dart';
import 'app/data/local/preference/preference_manager_impl.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(
    ScreenUtilInit(builder: (context, child) {
      return GetMaterialApp(
        title: "Tit",
        initialBinding: InitialBinding(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: lightTheme,
        themeMode: ThemeMode.system,
        //darkTheme: darkTheme,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
        ],
      );
    }),
  );
}

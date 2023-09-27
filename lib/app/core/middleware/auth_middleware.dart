import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tit/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {

  AuthMiddleware({required int priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    return FirebaseAuth.instance.currentUser != null
        ? const RouteSettings(name: Routes.MAIN)
        : null;
  }

}

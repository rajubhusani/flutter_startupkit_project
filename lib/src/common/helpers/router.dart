import 'package:flutter/material.dart';
import 'package:flutter_template_project/res/const.dart';
import 'package:flutter_template_project/src/pages/home_page.dart';
import 'package:flutter_template_project/src/pages/splash_page.dart';

class Router {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Consts.homeRoute:
        return getRouter(HomePage(title: settings.arguments as String));

      default:
        return getRouter(SplashPage());
    }
  }

  Route<bool> getRouter(Widget child) {
    return MaterialPageRoute(
      builder: (context) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template_project/res/colors.dart';
import 'package:flutter_template_project/res/const.dart';
import 'package:flutter_template_project/src/common/helpers/navigation_service.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

//Splash Page in Flutter, you can use native splash screen
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadRoutePage();
  }

  @override
  Widget build(BuildContext context) => _getBodyWidget();

  Widget _getBodyWidget() => Container(
      decoration: BoxDecoration(color: AppColors.white),
      child: Center(
        child: Text("Cognizant",
            style: TextStyle(color: Color.fromRGBO(0, 48, 135, 1.0))),
      ));

  void _loadRoutePage() {
    Timer(const Duration(seconds: 3), () {
      navService.pushReplacementNamed(Consts.homeRoute,
          args: "Flutter Sample App");
    });
  }
}

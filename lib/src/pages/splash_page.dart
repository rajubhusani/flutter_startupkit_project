import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template_project/res/colors.dart';
import 'package:flutter_template_project/res/const.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadRoutePage();
  }

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget() {
    return Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: Center(
          child: Text("Cognizant", style: TextStyle(color:Color.fromRGBO(0, 48, 135, 1.0))),
        ));
  }

  void _loadRoutePage() {
    new Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, Consts.homeRoute, arguments: "Flutter Sample App");
    });
  }
}

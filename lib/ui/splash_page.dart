import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';


class SplashPage extends StatelessWidget {
  static const routeName = '/splash_page_restaurant';
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),() => Navigator.pushReplacementNamed(context, HomePage.routeName));
    return Scaffold(
      body: Center(
        child: Image.asset("assets/restaurant.png",height: 200,width: 200,)
        ),
      );
  }
}
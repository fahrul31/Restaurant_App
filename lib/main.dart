import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName : (context) => const SplashPage(),
        HomePage.routeName :(context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id:
                  ModalRoute.of(context)?.settings.arguments as String,
            )
      },
    );
  }
}


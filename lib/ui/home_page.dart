import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/restaurants_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/ui/bookmark_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _favoriteText = 'Favorite';
  static const String _settingText = 'Setting';
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    const RestaurantPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: _homeText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: _favoriteText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: _settingText,
          ),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

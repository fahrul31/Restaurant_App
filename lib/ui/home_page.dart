import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _homeText = 'Home';
  static const String _searchText = 'Search';
  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(
        apiService: ApiService(),
      ),
      child: const RestaurantListPage(),
    ),
    const RestaurantSearch(),
  ];

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
            icon: Icon(Icons.search_rounded),
            label: _searchText,
          ),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

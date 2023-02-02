import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';

import '../widget/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurants'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                        arguments: provider.bookmarks[index].id);
                  },
                  child: CardRestaurant(
                    restaurant: provider.bookmarks[index],
                    urlImage: provider.baseUrlImage,
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}

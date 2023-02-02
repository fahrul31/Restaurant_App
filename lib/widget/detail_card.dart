import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/detail_restaurant.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';

class DetailCard extends StatelessWidget {
  final DetailRestaurant restaurant;
  final String urlImage;
  const DetailCard({Key? key, required this.restaurant, required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isBookmarked(restaurant.id),
        builder: (context, snapshot) {
          var isBookmarked = snapshot.data ?? false;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(urlImage + restaurant.pictureId),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(restaurant.name,
                              style: Theme.of(context).textTheme.headline5),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: isBookmarked
                                ? IconButton(
                                    icon: const Icon(Icons.favorite),
                                    onPressed: () =>
                                        provider.removeBookmark(restaurant.id),
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () => provider.addBookmark(
                                      Restaurant(
                                          id: restaurant.id,
                                          name: restaurant.name,
                                          description: restaurant.description,
                                          pictureId: restaurant.pictureId,
                                          city: restaurant.city,
                                          rating: restaurant.rating),
                                    ),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.asset(
                            "assets/mark.png",
                            height: 16,
                            width: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            restaurant.city,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Deskripsi",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Daftar Menu",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: restaurant.menus.foods.length +
                              restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            var menuList = List.from(restaurant.menus.foods)
                              ..addAll(restaurant.menus.drinks);
                            return _buildCard(menuList[index].name);
                          },
                          separatorBuilder: (content, _) =>
                              const SizedBox(width: 12),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildCard(String menu) {
    return Card(
      elevation: 0,
      color: Colors.grey,
      child: SizedBox(
        height: 150,
        width: 200,
        child: Center(
          child: Text(menu),
        ),
      ),
    );
  }
}

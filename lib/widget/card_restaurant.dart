import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant({
    Key? key,
    required this.restaurant,
    required this.urlImage,
  }) : super(key: key);

  final Restaurant restaurant;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          urlImage + restaurant.pictureId,
                          fit: BoxFit.fill,
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(restaurant.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
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
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                restaurant.rating.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

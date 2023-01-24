import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../data/api/api_service.dart';
import '../provider/restaurant_provider.dart';
import '../widget/card_restaurant.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = '/restaurant_search';
  const RestaurantSearch({super.key});

  @override
  State<RestaurantSearch> createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  var _txtSearch = TextEditingController(text: "melt");
  late RestaurantProvider restaurant;
  @override
  void dispose() {
    _txtSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider.search(
          apiService: ApiService(), query: _txtSearch.text),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    child: Consumer<RestaurantProvider>(
                      builder: (context, state, _) {
                        return TextField(
                          controller: _txtSearch,
                          onSubmitted: (value) {
                            if (value.isNotEmpty && value.length > 3) {
                              context
                                  .read<RestaurantProvider>()
                                  .update(context, value);
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: "Search Place",
                              hintStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<RestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width - 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/loading.png",
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Loading...",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state.state == ResultState.hasData) {
                        return ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.result.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result.restaurants[index];
                            var urlImage = state.baseUrlImage;
                            var id = state.result.restaurants[index].id;
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RestaurantDetailPage.routeName,
                                    arguments: id);
                              },
                              child: CardRestaurant(
                                  restaurant: restaurant, urlImage: urlImage),
                            );
                          },
                        );
                      } else if (state.state == ResultState.noData) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width - 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/noData.png",
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "No Data",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state.state == ResultState.error) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.width - 50,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/404.png",
                                  height: 100,
                                  width: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "404 not Found",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Material(
                            child: Text(''),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

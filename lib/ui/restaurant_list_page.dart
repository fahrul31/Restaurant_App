import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import '../widget/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _build(context),
      ),
    );
  }

  Widget _build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant ",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "Recommendation restaurant for you!",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 16),
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
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
                  Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                      arguments: id);
                },
                child:
                    CardRestaurant(restaurant: restaurant, urlImage: urlImage),
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
    );
  }
}

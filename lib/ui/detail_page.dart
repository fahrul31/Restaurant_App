import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/detail_card.dart';
import '../data/api/api_service.dart';
import '../data/model/detail_restaurant.dart';
import '../provider/restaurant_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
        apiService: ApiService(),
        id: id,
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: _build(),
        ),
      ),
    );
  }

  Widget _build() {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          var restaurant = state.result.restaurant;
          var urlImage = state.baseUrlImage;
          return DetailCard(restaurant: restaurant, urlImage: urlImage);
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return const Center(
            child: Material(
              child: Text("Internet Not Found"),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import '../data/model/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  RestaurantProvider({required this.apiService, this.query = ""}) {
    _fetchAllRestaurant();
  }
  RestaurantProvider.search({required this.apiService, required this.query}) {
    _fetchSearchRestaurant(query);
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';
  final String _baseUrlImage = "https://restaurant-api.dicoding.dev/images/medium/";

  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;
  String get message => _message;
  String get baseUrlImage => _baseUrlImage;

  void update(String q) {
    _fetchSearchRestaurant(q);
    notifyListeners();
  }

  void allRestaurant(){
    _fetchAllRestaurant();
    notifyListeners();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurantSearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _detailRestaurantResult;
  late ResultState _state;
  String _message = '';
  final String _baseUrlImage =
      "https://restaurant-api.dicoding.dev/images/large/";

  DetailRestaurantResult get result => _detailRestaurantResult;
  ResultState get state => _state;
  String get message => _message;
  String get baseUrlImage => _baseUrlImage;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

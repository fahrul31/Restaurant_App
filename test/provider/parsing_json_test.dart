import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Parsing JSON", () {
    test('Parsing JSON RestaurantResult is successful', () {
      // arrange
      final response = {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description":
                "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };
      // act
      var result = RestaurantResult.fromJson(response);
      // assert
      expect(result, isA<RestaurantResult>());
    });
    test(
        'Parsing JSON DetailRestaurant is successfull',
        () {
      // arrange
      final response = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      };
      // act
      var result = DetailRestaurant.fromJson(response);
      // assert
      expect(result, isA<DetailRestaurant>());
    });
  });
}

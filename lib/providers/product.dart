import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final int id;
  final String name;
  final String imageUrl;
  final String price;
  final String description;
  final int cuisineId;
  final int restaurantId;

  Product({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.description,
    @required this.cuisineId,
    @required this.restaurantId,
  });
}

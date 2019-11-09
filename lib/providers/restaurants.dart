import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/apiUtil.dart';
import '../providers/restaurant.dart';
import 'package:http/http.dart' as http;

class Restaurants with ChangeNotifier {
  List<Restaurant> _items = [];

  List<Restaurant> get items {
    return _items;
  }

  Future<void> fetchPopularRestaurants() async {
    final url = ApiUtil.Main_Api_Url + ApiUtil.fetchPopularRestaurants;
    final response = await http.get(url);
    final extractedData = jsonDecode(response.body);
    final List<Restaurant> loadedProducts = [];

    extractedData.forEach((item) {
      loadedProducts.add(Restaurant(
        id: item['id'],
        name: item['name'],
        description: item['description'],
        image: ApiUtil.imagePath + item['image'],
        email: item['email'],
        address: item['address'],
        contact: item['contact'],
        rating: item['rating'].toDouble(),
      ));
    });
    _items = loadedProducts;
    notifyListeners();
  }

  Restaurant findById(int id) {
    return _items.firstWhere(
      (restaurant) {
        return restaurant.id == id;
      },
    );
  }
}

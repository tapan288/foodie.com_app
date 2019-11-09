import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import '../models/apiUtil.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> _all_products = [];

  List<Product> get items {
    return _items;
  }

  List<Product> _restaurantProducts = [];

  List<Product> get restaurantProducts {
    return _restaurantProducts;
  }

  Future<void> fetchRecentProducts() async {
    final url = ApiUtil.Main_Api_Url + ApiUtil.fetchRecentProducts;
    final response = await http.get(url);
    List extractedData = json.decode(response.body);
    final List<Product> loadedProducts = [];

    extractedData.forEach((item) {
      loadedProducts.add(Product(
        id: item['id'],
        cuisineId: item['cuisine_id'],
        description: item['description'],
        imageUrl: ApiUtil.imagePath + item['image'],
        name: item['name'],
        price: item['price'],
        restaurantId: item['restaurant_id'],
      ));
    });
    _items = loadedProducts;
    notifyListeners();
  }

  Future<void> restaurantsAllProducts(int id) async {
    final url =
        ApiUtil.Main_Api_Url + ApiUtil.restaurantAllProducts + id.toString();
    try {
      final response = await http.get(url);
      // print(response.body);
      List data = json.decode(response.body);
      List<Product> products = [];
      data.forEach((item) {
        products.add(Product(
          id: item['id'],
          cuisineId: item['cuisine_id'],
          description: item['description'],
          imageUrl: ApiUtil.imagePath + item['image'],
          name: item['name'],
          price: item['price'],
          restaurantId: item['restaurant_id'],
        ));
      });
      _restaurantProducts = products;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> allProducts() async {
    final url = ApiUtil.Main_Api_Url + ApiUtil.allProducts;
    try {
      final response = await http.get(url);
      // print(response.body);
      List data = json.decode(response.body);
      List<Product> products = [];
      data.forEach((item) {
        products.add(Product(
          id: item['id'],
          cuisineId: item['cuisine_id'],
          description: item['description'],
          imageUrl: ApiUtil.imagePath + item['image'],
          name: item['name'],
          price: item['price'],
          restaurantId: item['restaurant_id'],
        ));
      });
      _all_products = products;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Product findById(int id) {
    return _all_products.firstWhere(
      (product) {
        return product.id == id;
      },
    );
  }
}

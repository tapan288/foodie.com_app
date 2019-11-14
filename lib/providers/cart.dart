import 'dart:convert';

import 'package:flutter/widgets.dart';
import '../models/apiUtil.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final double price;
  final String title;
  final int quantity;
  final String image;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity,
    @required this.image,
  });
}

class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};
  int userId;

  Map<int, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length == null ? 0 : _items.length;
  }

  double get totalamount {
    var total = 0.0;
    _items.forEach(
      (key, item) {
        total += item.price * item.quantity;
      },
    );
    return total;
  }

  Future<void> fetchItems() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData'));
    var _userId = extractedUserData['userId'];
    // print(_userId);
    final url = ApiUtil.Main_Api_Url + ApiUtil.cart + _userId.toString();
    // print(url);
    try {
      final response = await http.get(url);
      // print(response.body);
      List extractedData = jsonDecode(response.body);
      Map<int, CartItem> loadedCart = {};
      extractedData.forEach((item) {
        // print(item['price']);
        loadedCart.putIfAbsent(
          item['product_id'],
          () => CartItem(
            id: item['id'].toString(),
            title: item['title'],
            image: item['imageUrl'],
            price: item['price'].toDouble(),
            quantity: item['quantity'],
          ),
        );
      });
      _items = loadedCart;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addItem(
    String title,
    int productId,
    double price,
    String image,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData'));
    var _userId = extractedUserData['userId'];
    if (_items.containsKey(productId)) {
      const url = ApiUtil.Main_Api_Url + ApiUtil.updateCart;
      try {
        await http.post(
          url,
          body: jsonEncode({
            'product_id': productId,
            'user_id': _userId,
          }),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ).then((response) {
          // notifyListeners();
        });
      } catch (e) {
        // print(e);
      }

      // _items.update(
      //   productId,
      //   (existingCartItem) => CartItem(
      //     id: existingCartItem.id,
      //     title: existingCartItem.title,
      //     price: existingCartItem.price,
      //     image: existingCartItem.image,
      //     quantity: existingCartItem.quantity + 1,
      //   ),
      // );

    } else {
      // print(image);
      const url = ApiUtil.Main_Api_Url + ApiUtil.addToCart;
      try {
        await http.post(
          url,
          body: json.encode(
            {
              'title': title,
              'product_id': productId,
              'price': price,
              'imageUrl': image,
              'user_id': _userId,
            },
          ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ).then((response) {
          // notifyListeners();
        });
      } catch (e) {
        // print(e['message']);
      }

      // _items.putIfAbsent(
      //   productId,
      //   () => CartItem(
      //     id: DateTime.now().toString(),
      //     title: title,
      //     price: price,
      //     image: image,
      //     quantity: 1,
      //   ),
      // );

    }
    notifyListeners();
  }

  void removeItem(int productId, int cartId) async {
    final url = ApiUtil.Main_Api_Url + ApiUtil.deleteItem + cartId.toString();
    try {
      await http.get(url).then((response) {
        print(response.body);
        _items.remove(productId);
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}

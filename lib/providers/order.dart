import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'cart.dart';

class OrderItem {
  final double amount;
  final List<CartItem> products;
  OrderItem({
    @required this.amount,
    @required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int getLength() {
    return _orders.length;
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'http://10.0.3.2/foodie.com/public/api/addOrder';

    var response;
    try {
      response = await http.post(
        url,
        body: json.encode(
          {
            'amount': total,
            'products': cartProducts
                .map((cp) => {
                      'id': cp.id,
                      'price': cp.price,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'image': cp.image,
                    })
                .toList(),
          },
        ),
      );
    } catch (error) {}
  }
}

import 'dart:convert';
import 'package:flutter_food_ordering/models/apiUtil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart.dart';

class OrderItem {
  final double amount;
  final List<CartItem> products;
  OrderItem({
    @required this.amount,
    @required this.products,
  });
}

class SingleOrderItem {
  final int id;
  final String address;
  final String status;
  final String phone;
  final String method;
  final String amount;
  SingleOrderItem({
    @required this.id,
    @required this.address,
    @required this.amount,
    @required this.method,
    @required this.phone,
    @required this.status,
  });
}

class Orders with ChangeNotifier {
  List<SingleOrderItem> _orders = [];
  int _userId;

  List<SingleOrderItem> get orders {
    return [..._orders];
  }

  int getLength() {
    return _orders.length;
  }

  Future<void> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData'));
    _userId = extractedUserData['userId'];
    final url = ApiUtil.Main_Api_Url + ApiUtil.fetchOrders + _userId.toString();
    try {
      final response = await http.get(url);
      List extractedData = json.decode(response.body);
      // print(extractedData);
      // if (extractedData == null) {
      //   return;
      // }
      final List<SingleOrderItem> loadedOrders = [];
      extractedData.forEach((orderData) {
        loadedOrders.add(SingleOrderItem(
          id: orderData['id'],
          amount: orderData['total_amount'],
          address: orderData['delivery_address'],
          method: orderData['payment_type'],
          phone: orderData['phone'],
          status: orderData['status'],
        ));
      });
      // print(loadedOrders);
      _orders = loadedOrders;
      // print(_orders);
      notifyListeners();
    } catch (error) {}
  }

  Future<void> makeOrder(data) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData = json.decode(prefs.getString('userData'));
    _userId = extractedUserData['userId'];
    try {
      const url = ApiUtil.PaymentMainUrl + ApiUtil.PaymentUrl;
      final response = await http.post(
        url,
        body: json.encode({
          'amount': data['amount'],
          'token': data['token'],
        }),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      ).then((response) async {
        final responseData = jsonDecode(response.body);
        print(responseData);
        const url = ApiUtil.PaymentMainUrl + ApiUtil.MakeOrderUrl;
        final recievedResponse = await http.post(
          url,
          body: json.encode(
            {
              'response': responseData,
              'user_id': _userId,
            },
          ),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
        ).then((response) {
          print(jsonDecode(response.body));
        });
        // print(response.body);
      });
    } catch (e) {
      print(e);
    }
  }
}

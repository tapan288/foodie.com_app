import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/providers/order.dart';
import 'package:flutter_food_ordering/widgets/app_drawer.dart';
import 'package:flutter_food_ordering/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false).fetchOrders().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Page'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (context, index) => OrderItemScreen(
                ordersData.orders[index],
              ),
            ),
      drawer: AppDrawer(),
    );
  }
}

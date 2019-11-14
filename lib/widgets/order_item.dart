import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/providers/order.dart';

class OrderItemScreen extends StatefulWidget {
  final SingleOrderItem orderItem;
  OrderItemScreen(this.orderItem);

  @override
  _OrderItemScreenState createState() => _OrderItemScreenState();
}

class _OrderItemScreenState extends State<OrderItemScreen> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Amount:Rs.${widget.orderItem.amount}',
            ),
            subtitle: Column(
              children: <Widget>[
                Text('Address: ${widget.orderItem.address}'),
                Text('Status: ${widget.orderItem.status}'),
                Text('Payment Method: ${widget.orderItem.method}'),
                Text('Phone: ${widget.orderItem.phone}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

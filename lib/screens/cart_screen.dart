import 'package:flutter/material.dart';
import '../common.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../widgets/subtotal.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<Cart>(context).fetchItems();
      init = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: red[50],
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Your Food Cart',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items == null ? 0 : cart.items.length,
              itemBuilder: (ctx, index) => CartItemWidget(
                id: cart.items.values.toList()[index].id,
                imageUrl: cart.items.values.toList()[index].image,
                price: cart.items.values.toList()[index].price,
                quantity: cart.items.values.toList()[index].quantity,
                title: cart.items.values.toList()[index].title,
                productId: cart.items.keys.toList()[index],
              ),
            ),
          ),
          CartSubtotal(cart.totalamount),
        ],
      ),
    );
  }
}

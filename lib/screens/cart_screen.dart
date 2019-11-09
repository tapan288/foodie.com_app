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
  Future<void> _refreshCart() async {
    await Provider.of<Cart>(context).fetchItems();
  }

  var init = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    if (init) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Cart>(context).fetchItems().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    init = false;
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
      body: RefreshIndicator(
        onRefresh: _refreshCart,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  //   child: Text(
                  //     'Your Food Cart',
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
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
      ),
    );
  }
}

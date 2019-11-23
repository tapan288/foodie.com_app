import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/providers/cart.dart';
import 'package:flutter_food_ordering/providers/products.dart';
import 'package:flutter_food_ordering/screens/cart_screen.dart';
import 'package:flutter_food_ordering/widgets/food_card.dart';
import 'package:provider/provider.dart';
import '../values.dart';

class RestaurantSpecificProducts extends StatefulWidget {
  static const routeName = 'restaurant_products';
  @override
  _RestaurantSpecificProductsState createState() =>
      _RestaurantSpecificProductsState();
}

class _RestaurantSpecificProductsState
    extends State<RestaurantSpecificProducts> {
  var init = true;
  var isLoading = false;
  Future<void> _refresh() async {
    var restaurantId = ModalRoute.of(context).settings.arguments as int;
    await Provider.of<Cart>(context).fetchItems();
    await Provider.of<Products>(context).restaurantsAllProducts(restaurantId);
  }

  @override
  void didChangeDependencies() {
    if (init) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Cart>(context).fetchItems();
      var restaurantId = ModalRoute.of(context).settings.arguments as int;
      Provider.of<Products>(context)
          .restaurantsAllProducts(restaurantId)
          .then((_) {
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
    final products = Provider.of<Products>(context).restaurantProducts;

    var count = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          Spacer(),
                          Text(
                            'MENU',
                            style: headerStyle,
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.search), onPressed: () {}),
                          Stack(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(CartScreen.routeName);
                                },
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mainColor,
                                  ),
                                  child: Text(
                                    count.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: products.length,
                        itemBuilder: (ctx, index) =>
                            ChangeNotifierProvider.value(
                          value: products[index],
                          child: FoodCard(),
                        ),
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65,
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

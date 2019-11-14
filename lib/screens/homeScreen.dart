import 'package:flutter/material.dart';
import '../providers/products.dart';
import '../providers/restaurants.dart';
import '../screens/cart_screen.dart';
import '../widgets/categories.dart';
import '../widgets/popular_food.dart';
import '../widgets/popular_restaurants.dart';
import 'package:provider/provider.dart';
import '../common.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool initialRun = true;
  @override
  void didChangeDependencies() {
    if (initialRun) {
      Provider.of<Products>(context).fetchRecentProducts();
      Provider.of<Restaurants>(context).fetchPopularRestaurants();
      Provider.of<Products>(context).allProducts();
      initialRun = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "What would you like to eat?",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.notifications_none),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        }),
                    Positioned(
                      top: 10,
                      right: 12,
                      child: Container(
                        width: 12,
                        height: 12,
                        // child: Text('0'),
                        decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: grey[300], offset: Offset(2, 1), blurRadius: 5)
                    ]),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: red,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                        hintText: "Find food or Restuarant",
                        border: InputBorder.none),
                  ),
                  trailing: Icon(
                    Icons.filter_list,
                    color: red,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Categories(),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recently added Food Items",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
              ),
            ),
            Popular(),
            SizedBox(
              height: 5,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "Popular Restaurants",
            //     style: TextStyle(fontSize: 22, color: grey),
            //   ),
            // ),

            //Best Food

            PopularRestarants(),
          ],
        ),
      ),
    );
  }
}

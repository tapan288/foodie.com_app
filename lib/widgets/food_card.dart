import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/providers/cart.dart';
import 'package:flutter_food_ordering/providers/product.dart';
import 'package:flutter_food_ordering/screens/product_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../values.dart';

class FoodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final food = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return Container(
      child: Card(
        shape: roundedRectangle12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: food.id,
                  );
                },
                child: Image.network(
                  food.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 5,
                  loadingBuilder:
                      (context, Widget child, ImageChunkEvent progress) {
                    if (progress == null) return child;
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes
                                : null),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Text(
                food.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RatingBar(
                    initialRating: 4,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 14,
                    unratedColor: Colors.black,
                    itemPadding: EdgeInsets.only(right: 4.0),
                    ignoreGestures: true,
                    itemBuilder: (context, index) =>
                        Icon(Icons.star, color: Colors.red),
                    onRatingUpdate: (rating) {},
                  ),
                  Text('15'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rs. ${food.price}',
                    style: titleStyle,
                  ),
                  Card(
                    margin: EdgeInsets.only(right: 0),
                    shape: roundedRectangle4,
                    color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        cart.addItem(
                          food.name,
                          food.id,
                          double.parse(food.price),
                          food.imageUrl,
                        );
                        Scaffold.of(context).hideCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item added to the Cart'),
                          ),
                        );
                      },
                      splashColor: Colors.white70,
                      customBorder: roundedRectangle4,
                      child: Icon(Icons.add),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

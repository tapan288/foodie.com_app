import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/product_screen.dart';
import '../widgets/rating.dart';
import '../widgets/small_floating_button.dart';
import 'package:provider/provider.dart';
import '../common.dart';

class Popular extends StatelessWidget {
  Widget build(BuildContext context) {
    List<Product> foodList = Provider.of<Products>(context).items;
    return Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: red[50],
                              offset: Offset(3, 8),
                              blurRadius: 15)
                        ]),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: foodList[index].id,
                              );
                            },
                            child: Hero(
                              tag: foodList[index].imageUrl,
                              child: Image.network(
                                "${foodList[index].imageUrl}",
                                width: double.infinity,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: 140,
                                child: Text(
                                  foodList[index].name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SmallButton(Icons.favorite_border),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "4.5",
                                    style: TextStyle(color: grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Rating(),
                                  Rating(),
                                  Rating(),
                                  Rating(),
                                  Rating(),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "(298)",
                                    style: TextStyle(color: grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Rs ${foodList[index].price}",
                                style: TextStyle(color: black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

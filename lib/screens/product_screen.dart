import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = 'product_detail';

  @override
  Widget build(BuildContext context) {
    final int productId = ModalRoute.of(context).settings.arguments as int;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width - 120,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Hero(
                    tag: loadedProduct.imageUrl,
                    child: Image.network(
                      "${loadedProduct.imageUrl}",
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        loadedProduct.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rs. ${loadedProduct.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'by ${loadedProduct.restaurantId}Restaurant name',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      onPressed: () {
                        cart.addItem(
                          loadedProduct.name,
                          loadedProduct.id,
                          double.parse(loadedProduct.price),
                          loadedProduct.imageUrl,
                        );
                        // Scaffold.of(context).hideCurrentSnackBar();
                        // Scaffold.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Item added to the Cart'),
                        //   ),
                        // );
                      },
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    "Description".toUpperCase(),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: <Widget>[
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(FontAwesomeIcons.minus),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            // cart.addItem(
            //     loadedProduct.name,
            //     loadedProduct.id,
            //     double.parse(loadedProduct.price),
            //     loadedProduct.imageUrl);
            //       },
            //       child: Container(
            //         width: 150,
            //         height: 50,
            //         child: Text(
            //           'Add To Cart',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //         decoration: BoxDecoration(
            //           color: Colors.red,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(FontAwesomeIcons.plus),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

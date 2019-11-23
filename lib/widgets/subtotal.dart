import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/providers/order.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  final double totalAmount;
  CartSubtotal(this.totalAmount);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Subtotal'),
                Text('Rs.${totalAmount.toString()}'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Shipping'),
                Text('0.0'),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Total'),
                Text('Rs.${totalAmount.toString()}'),
              ],
            ),
            Divider(),
            Text('Select Payment Method'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: 135,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    color: Colors.purple,
                    textColor: Colors.white,
                    child: Text(
                      "Khalti",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    onPressed: () {
                      FlutterKhalti(
                        urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
                        publicKey:
                            "test_public_key_4f87617d1e3942209abcac1137f47b50",
                        productId: "1233",
                        productName: "Test 2",
                        amount: totalAmount * 100,
                        productUrl:
                            'http://gameofthrones.wikia.com/wiki/Dragons',
                        customData: {
                          "test": "asass",
                        },
                      ).initPayment(
                        onSuccess: (data) {
                          print("success");
                          print(data);
                          order.makeOrder(data);
                          // print(data['amount']);
                          // print(data['product_url']);
                        },
                        onError: (error) {
                          print("error");
                          print(error);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 135,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text(
                      "COD",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 30.0,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

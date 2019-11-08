import 'package:flutter/material.dart';
import '../widgets/rating.dart';
import '../widgets/small_floating_button.dart';

import '../common.dart';

class BestFoodSecondary extends StatefulWidget {
  @override
  _BestFoodSecondaryState createState() => _BestFoodSecondaryState();
}

class _BestFoodSecondaryState extends State<BestFoodSecondary> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_, index) {
      return Padding(
        padding: EdgeInsets.all(2),
        child: Stack(
          children: <Widget>[
            Card(
              child: Container(
                height: 275,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset("images/food.jpg"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                              height: 40,
                              child: Column(
                                children: <Widget>[
                                  Text("Some Food"),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: <Widget>[
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
                                          style: TextStyle(
                                              color: grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "\$34.99",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmallButton(Icons.favorite),
            )
          ],
        ),
      );
    });
  }
}

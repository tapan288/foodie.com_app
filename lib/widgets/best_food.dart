import 'package:flutter/material.dart';

import '../common.dart';
import 'rating.dart';
import 'small_floating_button.dart';

class BestFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/food.jpg",
                      ),
                    ),
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
                                          color: grey,
                                          fontSize: 12,
                                        ),
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
  }
}

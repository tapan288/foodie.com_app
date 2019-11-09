import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/screens/restaurant_products.dart';
import '../providers/restaurant.dart';
import '../providers/restaurants.dart';
import '../screens/popular.dart';
import '../widgets/slide_item.dart';
import 'package:provider/provider.dart';

class PopularRestarants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants = Provider.of<Restaurants>(context).items;
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Popular Restaurants",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                ),
              ),
              FlatButton(
                child: Text(
                  "See all",
                  style: TextStyle(
                    //  fontSize: 22,
                    //  fontWeight: FontWeight.w800,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(PopularRestaurantsList.routeName);
                },
              ),
            ],
          ),

          SizedBox(height: 10.0),

          //Horizontal List here
          Container(
            height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants == null ? 0 : restaurants.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          RestaurantSpecificProducts.routeName,
                          arguments: restaurants[index].id);
                    },
                    child: SlideItem(
                      img: restaurants[index].image,
                      title: restaurants[index].name,
                      address: restaurants[index].address,
                      rating: restaurants[index].rating.toString(),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}

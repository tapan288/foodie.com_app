import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/screens/homeScreen.dart';
import '../screens/cart_screen.dart';
import '../common.dart';
import 'orders_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPageIndex = 0;
  List<Map<String, Object>> _pages = [
    {'page': HomeScreen(), 'title': 'Home'},
    {'page': CartScreen(), 'title': 'CartScreen'},
    {'page': OrdersScreen(), 'title': 'OrdersScreen'},
  ];
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: _pages[_selectedPageIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(
              Icons.shopping_cart,
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            title: SizedBox.shrink(),
            icon: Icon(
              Icons.account_circle,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

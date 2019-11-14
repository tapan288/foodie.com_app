import 'package:flutter/material.dart';
import 'package:flutter_food_ordering/widgets/app_drawer.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: AppDrawer(),
    );
  }
}

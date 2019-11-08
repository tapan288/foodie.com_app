import 'package:flutter/material.dart';
import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'providers/restaurants.dart';
import 'screens/cart_screen.dart';
import 'screens/home.dart';
import 'screens/login_screen.dart';
import 'screens/popular.dart';
import 'screens/product_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Restaurants(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Foodie.com',
          home: auth.isAuth
              ? Home()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          routes: {
            CartScreen.routeName: (ctx) => CartScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            PopularRestaurantsList.routeName: (ctx) => PopularRestaurantsList(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            SignupScreen.routeName: (ctx) => SignupScreen(),
          },
        ),
      ),
    );
  }
}

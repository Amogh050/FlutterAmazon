import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon/features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    default:
      return MaterialPageRoute(
        builder:
            (_) =>
                Scaffold(body: Center(child: Text("Screen does not exsist!!"))),
      );
  }
}

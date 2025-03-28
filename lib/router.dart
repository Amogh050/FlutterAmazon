import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/bottom_bar.dart';
import 'package:flutter_amazon/features/address/screens/address_screen.dart';
import 'package:flutter_amazon/features/admin/screens/add_product_screen.dart';
import 'package:flutter_amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter_amazon/features/home/screens/category_deals_screen.dart';
import 'package:flutter_amazon/features/home/screens/home_screen.dart';
import 'package:flutter_amazon/features/order_details/order_details.dart';
import 'package:flutter_amazon/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_amazon/features/search/screens/search_screen.dart';
import 'package:flutter_amazon/models/order.dart';
import 'package:flutter_amazon/models/product.dart';

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
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(category: category),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: product),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) => OrderDetailScreen(order: order),
      );
    default:
      return MaterialPageRoute(
        builder:
            (_) =>
                Scaffold(body: Center(child: Text("Screen does not exsist!!"))),
      );
  }
}

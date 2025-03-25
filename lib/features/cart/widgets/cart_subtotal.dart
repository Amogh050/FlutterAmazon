import 'package:flutter/material.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text('Subtotal ', style: TextStyle(fontSize: 20)),
          Text('\$$sum', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_amazon/constants/error_handling.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/constants/utils.dart';
import 'package:flutter_amazon/models/product.dart';
import 'package:flutter_amazon/models/user.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id, 'rating': rating}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        User user = userProvider.user.copyWith(
          cart: jsonDecode(res.body)['cart']
        );
        userProvider.setUserFromModel(user);
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

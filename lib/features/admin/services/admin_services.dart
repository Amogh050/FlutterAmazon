// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon/constants/error_handling.dart';
import 'package:flutter_amazon/constants/global_variables.dart';
import 'package:flutter_amazon/constants/utils.dart';
import 'package:flutter_amazon/models/product.dart';
import 'package:flutter_amazon/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic(
        'dndcsydl6',
        'lhyfs8ih',
      );
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        if (!File(images[i].path).existsSync()) {
          debugPrint('Skipping: File not found at ${images[i].path}');
          continue;
        }
        try {
          String sanitizedName = name.replaceAll(RegExp(r'[^\w-]'), '_');
          CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: sanitizedName),
          );
          imageUrls.add(res.secureUrl);
        } catch (e) {
          debugPrint(e.toString());
        }
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );


      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

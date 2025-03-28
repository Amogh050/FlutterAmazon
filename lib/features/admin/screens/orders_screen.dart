import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/loader.dart';
import 'package:flutter_amazon/features/account/widgets/single_product.dart';
import 'package:flutter_amazon/features/admin/services/admin_services.dart';
import 'package:flutter_amazon/features/order_details/order_details.dart';
import 'package:flutter_amazon/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? Loader()
        : GridView.builder(
          itemCount: orders!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final orderData = orders![index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orderData);
              },
              child: SizedBox(
                height: 140,
                child: SingleProduct(image: orderData.products[0].images[0]),
              ),
            );
          },
        );
  }
}

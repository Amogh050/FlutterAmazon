import 'package:flutter/material.dart';
import 'package:flutter_amazon/common/widgets/loader.dart';
import 'package:flutter_amazon/features/admin/models/sales.dart';
import 'package:flutter_amazon/features/admin/services/admin_services.dart';
import 'package:flutter_amazon/features/admin/widgets/category_products_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningsData = await adminServices.getEarnings(context);
    totalSales = earningsData['totalEarnings'];
    earnings = earningsData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '\$$totalSales',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 250,
                  child: CategoryProductsChart(
                    sales: earnings!,
                  ),
                ),
              ],
            ),
          );
  }
}

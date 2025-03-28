import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon/features/admin/models/sales.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> sales;
  const CategoryProductsChart({
    Key? key,
    required this.sales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Build bar groups from the sales data.
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < sales.length; i++) {
      final sale = sales[i];
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: sale.earnings.toDouble(),
              // Slightly narrower bars to fit all categories
              width: 12, 
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
          ],
        ),
      );
    }

    // Determine the maximum Y value for proper scaling.
    double maxY = sales
        .map((s) => s.earnings)
        .reduce((a, b) => a > b ? a : b)
        .toDouble() * 1.2;

    return Padding(
      // Minimal horizontal padding so categories remain visible
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          barGroups: barGroups,
          alignment: BarChartAlignment.spaceAround,
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                // Slightly reduced space
                reservedSize: 30,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final int intValue = value.toInt();
                  String formatted;
                  if (intValue >= 1000) {
                    double valueK = intValue / 1000;
                    // e.g., 1k or 1.2k
                    formatted = (valueK == valueK.roundToDouble())
                        ? '${valueK.toInt()}k'
                        : '${valueK.toStringAsFixed(1)}k';
                  } else {
                    formatted = intValue.toString();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      formatted,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < sales.length) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 5.0,
                        right: 5.0,
                      ),
                      // FittedBox to handle longer category names
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          sales[index].label,
                          style: const TextStyle(fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}

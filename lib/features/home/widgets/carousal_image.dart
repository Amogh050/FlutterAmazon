import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon/constants/global_variables.dart';

class CarousalImage extends StatelessWidget {
  const CarousalImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          GlobalVariables.carouselImages.map((i) {
            return Builder(
              builder:
                  (context) => Image.network(i, height: 200, fit: BoxFit.cover),
            );
          }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}

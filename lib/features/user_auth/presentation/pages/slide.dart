// ignore_for_file: prefer_const_constructors, unnecessary_import, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, unused_import, use_super_parameters

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  final List<String> assetImages = [
    'images/ba1.jpg',
    'images/ba2.png',
    'images/ba3.png',
    'images/ba4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: assetImages.length,
              itemBuilder: (context, index, realIndex) {
                final assetImage = assetImages[index];
                return buildImage(assetImage, index);
              },
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: Duration(seconds: 2),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
            ),
            SizedBox(height: 12),
            buildIndicator(),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.blue),
        activeIndex: activeIndex,
        count: assetImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String assetImage, int index) => Container(
        child: Image.asset(assetImage, fit: BoxFit.cover),
      );
}

void main() {
  runApp(MaterialApp(
    home: SliderP(),
  ));
}

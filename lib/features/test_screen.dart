import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Carousel Slider Example'),
        ),
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
            ),
            items: [
              'https://via.placeholder.com/600x200',
              'https://via.placeholder.com/600x200',
              'https://via.placeholder.com/600x200',
            ].map((String imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

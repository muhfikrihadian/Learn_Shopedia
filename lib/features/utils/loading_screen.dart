import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ChildProduct(),
                  ChildProduct(),
                ],
              ),
              Row(
                children: [
                  ChildProduct(),
                  ChildProduct(),
                ],
              ),
              Row(
                children: [
                  ChildProduct(),
                  ChildProduct(),
                ],
              ),
              Row(
                children: [
                  ChildProduct(),
                  ChildProduct(),
                ],
              ),
              Row(
                children: [
                  ChildProduct(),
                  ChildProduct(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
        height: 150,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 15,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              height: 15,
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
            )
          ],
        ),
        )
    );
  }
}

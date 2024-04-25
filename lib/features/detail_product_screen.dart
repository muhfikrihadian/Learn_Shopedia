import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopedia/features/utils/loading_screen.dart';
import 'package:shopedia/features/test_screen.dart';
import 'package:shopedia/features/utils/message_screen.dart';
import 'package:shopedia/helpers/colours.dart';
import 'package:shopedia/models/product.dart';
import 'package:shopedia/providers/product_provider.dart';

import '../helpers/strings.dart';

class DetailProductScreen extends StatefulWidget {
  final int idProduct;
  final String category;

  DetailProductScreen({required this.idProduct, required this.category});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  num totalPrice = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [];

    void calculatePrice(num price, num discount) {
      totalPrice = (price - (price * (discount / 100)));
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  return FutureBuilder<void>(
                    future: provider.getDetailProduct(widget.idProduct),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error" + snapshot.toString());
                      } else {
                        calculatePrice(provider.dataDetailProduct.price ?? 0, provider.dataDetailProduct.discountPercentage ?? 0);
                        for (int i = 0; i < provider.dataDetailProduct.images!.length; i++) {
                          items.add(provider.dataDetailProduct.images![i]);
                        }
                        return Container(
                          child: Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  pauseAutoPlayOnTouch: true,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                ),
                                items: items.map((String imageUrl) {
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
                              Padding(
                                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '\$${totalPrice.toStringAsFixed(2)}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$${provider.dataDetailProduct.price ?? 0.toStringAsFixed(2)}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/ic_rating.png",
                                              width: 10,
                                              height: 10,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              provider.dataDetailProduct.rating
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      provider.dataDetailProduct.title ?? "-",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/icons/ic_official.png",
                                          width: 15,
                                          height: 15,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Flexible(
                                          child: Text(
                                            provider.dataDetailProduct.brand ?? "-",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      provider.dataDetailProduct.description ?? "-",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: Text(
                "Similiar Products",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    return FutureBuilder<void>(
                      future: provider.getProductsByCategory(widget.category),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LoadingScreen();
                        } else if (snapshot.hasError) {
                          return MessageScreen(message: MsgErrorServer);
                        } else {
                          return GridView.builder(
                            itemCount:
                                (provider.dataProductsCat.length / 2).ceil(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, i) {
                              return ChildProduct(provider.dataProductsCat[i]);
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        )),
      ),
      bottomSheet: ChildBottom(totalPrice),
    );
  }
}

class ChildSnapshot extends StatelessWidget {
  final List<Widget> widgets;

  ChildSnapshot(this.widgets) {}

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
      ),
      items: widgets,
    );
  }
}

class ChildLoadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
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
              ],
            ),
          )),
    );
  }
}

class ChildBottom extends StatelessWidget {
  num price = 0;

  ChildBottom(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            MaterialButton(
              minWidth: 50,
              height: 50,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: ColorPrimary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: FaIcon(
                FontAwesomeIcons.cartPlus,
                size: 20,
                color: ColorPrimary,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: MaterialButton(
                height: 50,
                color: ColorPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text('\$${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChildProduct extends StatelessWidget {
  ProductModel productModel;
  late num totalPrice;
  late num price;
  late num discount;

  ChildProduct(this.productModel) {
    price = productModel.price ?? 0;
    discount = productModel.discountPercentage ?? 0;
    totalPrice = (price - (price * (discount / 100)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailProductScreen(
                    idProduct: productModel.id ?? 0,
                    category: productModel.category ?? "",
                  )),
        );
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: SizedBox.fromSize(
                    child: Image.network(
                      productModel.thumbnail ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  productModel.title ?? "-",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '\$${productModel.price?.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/ic_official.png",
                            width: 10,
                            height: 10,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Flexible(
                            child: Text(
                              productModel.brand ?? "-",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/ic_rating.png",
                          width: 10,
                          height: 10,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          productModel.rating.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

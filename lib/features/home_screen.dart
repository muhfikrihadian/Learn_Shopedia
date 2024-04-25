import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopedia/features/category_screen.dart';
import 'package:shopedia/features/detail_product_screen.dart';
import 'package:shopedia/features/utils/loading_screen.dart';
import 'package:shopedia/features/products_screen.dart';
import 'package:shopedia/features/search_screen.dart';
import 'package:shopedia/features/test_screen.dart';
import 'package:shopedia/features/utils/message_screen.dart';
import 'package:shopedia/helpers/colours.dart';
import 'package:shopedia/helpers/strings.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> listCatTags = [
    "smartphones",
    "laptops",
    "home-decoration",
    "lighting",
    "furniture",
    "automotive",
    "motorcycle",
    "groceries",
    "fragrances",
    "skincare",
    "sunglasses",
    "tops",
    "mens-shirts",
    "mens-shoes",
    "mens-watches",
    "womens-dresses",
    "womens-shoes",
    "womens-watches",
    "womens-bags",
    "womens-jewellery"
  ];
  List<String> listCatName = [
    "Smartphone",
    "Laptop",
    "Home\nDecoration",
    "Lighting",
    "Furniture",
    "Automotive",
    "Motorcycle",
    "Groceries",
    "Fragrances",
    "Skincare",
    "Sunglasses",
    "Tops",
    "Mens\nShirts",
    "Mens\nShoes",
    "Mens\nWatches",
    "Womens\nDresses",
    "Womens\nShoes",
    "Womens\nWatches",
    "Womens\nBags",
    "Womens\nJewellery"
  ];
  List<String> listCatPict = [
    "ic_smartphones.png",
    "ic_laptops.png",
    "ic_home_decoration.png",
    "ic_lighting.png",
    "ic_furniture.png",
    "ic_automotive.png",
    "ic_motorcycle.png",
    "ic_groceries.png",
    "ic_fragrances.png",
    "ic_skincare.png",
    "ic_sunglasses.png",
    "ic_tops.png",
    "ic_mens_shirts.png",
    "ic_mens_shoes.png",
    "ic_mens_watches.png",
    "ic_women_dresses.png",
    "ic_womens_shoes.png",
    "ic_womens_watches.png",
    "ic_woman_bags.png",
    "ic_women_jewellery.png"
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onSubmitted: (query) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(query: query),
                ),
              );
            },
            decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: SizedBox.fromSize(
                child: Image.asset(
                    "assets/images/img_avatar.jpeg",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/icons/ic_icon.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text('Products'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            Expanded(
              child: Container(child: SizedBox()),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "© Muhammad Fikri Hadian",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < 10; i++)
                                ChildCategory(listCatTags[i], listCatName[i],
                                    listCatPict[i]),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 10; i < 20; i++)
                                ChildCategory(listCatTags[i], listCatName[i],
                                    listCatPict[i]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Products",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: productProvider.isLoading ? Center(child: LoadingScreen(),) : GridView.builder(
                    controller: _scrollController,
                    itemCount: productProvider.dataProducts.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, i) {
                      return ChildProduct(productProvider.dataProducts[i]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildCategory extends StatelessWidget {
  String tag = "";
  String title = "";
  String image = "";

  ChildCategory(this.tag, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              query: tag,
              name: title,
            ),
          ),
        );
      },
      child: Container(
        height: 80,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/" + image,
              width: 40,
              height: 40,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
              ),
            )
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

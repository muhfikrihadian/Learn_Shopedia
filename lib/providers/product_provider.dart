import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get dataProducts => _products;
  List<ProductModel> _productsCat = [];

  List<ProductModel> get dataProductsCat => _productsCat;
  List<ProductModel> _productsSearch = [];

  List<ProductModel> get dataProductsSearch => _productsSearch;
  ProductModel _detailProduct = ProductModel();

  ProductModel get dataDetailProduct => _detailProduct;

  int _pageSkip = 0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isBreak = false;
  bool get isBreak => _isBreak;

  Future<List<ProductModel>> fetchProducts() async {
    final url = "https://dummyjson.com/products?limit=10&skip=" + _pageSkip.toString();
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['products'].cast<Map<String, dynamic>>();
      List<ProductModel> _newProducts = result.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
      return _newProducts;
    } else {
      throw Exception();
    }
  }

  Future<void> getProducts() async {
    try {
      if (_isBreak == false) {
        if (_isLoading == false) {
          _isLoading = true;
          final List<ProductModel> fetchedProducts = await fetchProducts();
          if(fetchedProducts.length == 0){
            _isBreak = true;
          }
          _pageSkip += fetchedProducts.length;
          print("FetchLength" + fetchedProducts.length.toString());
          print("PageSkip" + _pageSkip.toString());
          _products.addAll(fetchedProducts);
          _isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      throw Exception();
    }
  }


  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final url = 'https://dummyjson.com/products/category/' + category;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("RespProductsCat" + response.body);
      final result =
          json.decode(response.body)['products'].cast<Map<String, dynamic>>();
      _productsCat = result
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
      return _productsCat;
    } else {
      throw Exception();
    }
  }

  Future<List<ProductModel>> getSearchProducts(String query) async {
    final url = 'https://dummyjson.com/products/search?q=' + query;
    print("ReqSearch" + url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("RespProductsSearch" + response.body);
      final result =
          json.decode(response.body)['products'].cast<Map<String, dynamic>>();
      _productsSearch = result
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
      return _productsSearch;
    } else {
      throw Exception();
    }
  }

  Future<ProductModel> getDetailProduct(int id) async {
    _detailProduct = _products.firstWhere((i) => i.id == id);
    String title = _detailProduct.title ?? "";
    print("DetailProd " + title);
    return _detailProduct;
  }

  Future<bool> addProduct(String title, String description, String category,
      String brand, String price) async {
    var endpointUrl = "https://dummyjson.com/products/add";
    final uri = Uri.parse(endpointUrl);
    var body = {
      'title': title,
      'description': description,
      'category': category,
      'brand': brand,
      'price': price,
    };
    var bodyJson = json.encode(body);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: bodyJson,
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editProduct(String id, String title, String description,
      String category, String brand, String price) async {
    var endpointUrl = "https://dummyjson.com/products/" + id;
    final uri = Uri.parse(endpointUrl);
    var body = {
      'title': title,
      'description': description,
      'category': category,
      'brand': brand,
      'price': price,
    };
    var bodyJson = json.encode(body);
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: bodyJson,
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shopedia/providers/product_provider.dart';

import '../helpers/colours.dart';
import '../helpers/strings.dart';

class EditProduct extends StatefulWidget {
  final int idProduct;
  EditProduct({required this.idProduct});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool _isLoading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  void editProduct(BuildContext context) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _categoryController.text.isEmpty || _brandController.text.isEmpty || _priceController.text.isEmpty) {
      EasyLoading.showError('Please fill in all data !');
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<ProductProvider>(context, listen: false).editProduct(widget.idProduct.toString(), _titleController.text, _descriptionController.text, _categoryController.text, _brandController.text, _priceController.text).then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Product edited successfully !');
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError(MsgErrorServer);
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<ProductProvider>(context, listen: false).getDetailProduct(widget.idProduct).then((response) {
        _titleController.text = response.title??"";
        _descriptionController.text = response.description??"";
        _priceController.text = response.price.toString();
        _brandController.text = response.brand??"";
        _categoryController.text = response.category??"";
        setState(() {

        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: ColorText),
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(color: ColorText),
                  filled: true,
                  fillColor: ColorGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.text_fields_outlined,
                    color: ColorText,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _categoryController,
                style: TextStyle(color: ColorText),
                decoration: InputDecoration(
                  hintText: 'Category',
                  hintStyle: TextStyle(color: ColorText),
                  filled: true,
                  fillColor: ColorGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.category,
                    color: ColorText,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _brandController,
                style: TextStyle(color: ColorText),
                decoration: InputDecoration(
                  hintText: 'Brand',
                  hintStyle: TextStyle(color: ColorText),
                  filled: true,
                  fillColor: ColorGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.label_important_outline,
                    color: ColorText,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: _descriptionController,
                style: TextStyle(color: ColorText),
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: ColorText),
                  filled: true,
                  fillColor: ColorGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.description,
                    color: ColorText,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                style: TextStyle(color: ColorText),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Price',
                  hintStyle: TextStyle(color: ColorText),
                  filled: true,
                  fillColor: ColorGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: ColorText,
                  ),
                ),
              ),
              Expanded(
                child: Container(child: SizedBox()),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          height: 50,
          color: ColorPrimary,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: () {
            editProduct(context);
          },
          child: Text('Submit'),
        ),
      ),
    );
  }
}

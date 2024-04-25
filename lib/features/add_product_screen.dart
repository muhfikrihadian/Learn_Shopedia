import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shopedia/helpers/strings.dart';
import 'package:shopedia/providers/product_provider.dart';

import '../helpers/colours.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _isLoading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  void addProduct(BuildContext context) {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || _categoryController.text.isEmpty || _brandController.text.isEmpty || _priceController.text.isEmpty) {
      EasyLoading.showError('Please fill in all data !');
    } else {
      if (!_isLoading) {
        setState(() {
          _isLoading = true;
        });
        EasyLoading.show(status: 'Loading...');
        Provider.of<ProductProvider>(context, listen: false).addProduct(_titleController.text, _descriptionController.text, _categoryController.text, _brandController.text, _priceController.text).then((res) {
          if (res) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess('Product added successfully !');
            setState(() {
              _isLoading = false;
            });
            Navigator.pop(context);
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError(
                MsgErrorServer);
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
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
            addProduct(context);
          },
          child: Text('Submit'),
        ),
      ),
    );
  }
}

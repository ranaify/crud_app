import 'dart:convert';
import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({super.key, required this.product});
  static const String name = '/update_new_product';
  final Product product;

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _priceTextEditingController = TextEditingController();
  final TextEditingController _totalPriceTextEditingController = TextEditingController();
  final TextEditingController _quantityTextEditingController = TextEditingController();
  final TextEditingController _imageTextEditingController = TextEditingController();
  final TextEditingController _productCodeTextEditingController = TextEditingController();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextEditingController.text =widget.product.productName ?? "";
    _priceTextEditingController.text =widget.product.unitPrice ?? "";
    _totalPriceTextEditingController.text =widget.product.totalPrice ?? "";
    _quantityTextEditingController.text =widget.product.quantity ?? "";
    _imageTextEditingController.text =widget.product.image ?? "";
    _productCodeTextEditingController.text =widget.product.productCode ?? "";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Update Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            // TODO: complete form validation
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                      hintText: "Name",
                      labelText: "Product Name"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _priceTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Price",
                      labelText: "Product Price"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _totalPriceTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Total Price",
                      labelText: "Product Total Price"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Total Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _quantityTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Quantity",
                      labelText: "Product Quantity"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _productCodeTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Code",
                      labelText: "Product Code"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: _imageTextEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      hintText: "Image Url",
                      labelText: "Product Image"
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Product Image';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                Visibility(
                  visible: _updateProductInProgress = true,
                  replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: (){
                    // TODO:check form validation
                    _updateProduct();
                  }, child: Text("Update Product")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProduct() async{
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}");

    Map<String, dynamic> requestBody ={
      "Img":_imageTextEditingController,
      "ProductCode":_productCodeTextEditingController,
      "ProductName":_nameTextEditingController,
      "Qty":_quantityTextEditingController,
      "TotalPrice":_totalPriceTextEditingController,
      "UnitPrice":_priceTextEditingController
    };

    Response response = await post(
        uri,
        headers: {
          'Content-type': "application/json"
        },
        body:  jsonEncode(requestBody));
    _updateProductInProgress = false;
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product has been updated")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product updated Failed Try again")));
    }
  }

  @override
  void dispose() {
    _nameTextEditingController.dispose();
    _productCodeTextEditingController.dispose();
    _priceTextEditingController.dispose();
    _totalPriceTextEditingController.dispose();
    _quantityTextEditingController.dispose();
    _imageTextEditingController.dispose();
    super.dispose();
  }
}

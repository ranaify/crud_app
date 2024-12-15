import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});
static const String name = '/add_new_product';
  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _priceTextEditingController = TextEditingController();
  final TextEditingController _totalPriceTextEditingController = TextEditingController();
  final TextEditingController _quantityTextEditingController = TextEditingController();
  final TextEditingController _imageTextEditingController = TextEditingController();
  final TextEditingController _productCodeTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(height: 10,),
                TextFormField(
                  controller: _priceTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
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
                SizedBox(height: 10,),
                TextFormField(
                  controller: _totalPriceTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
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
                SizedBox(height: 10,),
                TextFormField(
                  controller: _quantityTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(height: 10,),
                TextFormField(
                  controller: _productCodeTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(height: 10,),
                TextFormField(
                  controller: _imageTextEditingController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                SizedBox(height: 10,),
                SizedBox(height: 16,),
                SizedBox(height: 10,),
                Visibility(
                  visible: _addNewProductInProgress == false,
                 replacement: Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _addNewProduct();

                    }
                  }, child: Text("Add Product")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewProduct() async{
  _addNewProductInProgress = true;
   setState(() {});
   Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
   Map<String, dynamic> requestBody = {
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
     body: jsonEncode(requestBody)
   );

  _addNewProductInProgress =false;
   setState(() {});
   if(response.statusCode == 200){
     _clearTextFields();
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Product Added"),));

   }else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Product Add Failed Try Again"),));
   }
  }

  void _clearTextFields(){
    _nameTextEditingController.clear();
    _productCodeTextEditingController.clear();
    _priceTextEditingController.clear();
    _totalPriceTextEditingController.clear();
    _quantityTextEditingController.clear();
    _imageTextEditingController.clear();
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

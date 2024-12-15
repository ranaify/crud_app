import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/product.dart';
import '../widgets/product_item.dart';
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  List<Product> productList = [];
  bool _getProductListInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _getProductListInProgress == true,
      replacement: Center(
        child: CircularProgressIndicator(),
      ),
      child: ListView.builder(
        itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: productList[index],
            );
          },
      ),
    );
  }

  Future<void> _getProductList() async{

    setState(() {
      _getProductListInProgress = true;
    });
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
    Response response = await get(uri);

    if(response.statusCode == 200){
      final decodedData = jsonDecode(response.body);

      for(Map<String, dynamic> p in decodedData["data"]){
        Product product = Product(
          id: p["_id"],
          productName: p["ProductName"],
          productCode: p["ProductCode"],
          quantity: p["Qty"],
          unitPrice: p["UnitPrice"],
          image: p["Img"],
          totalPrice: p["TotalPrice"],
          createdDate: p["CreatedDate"],
        );
        productList.add(product);
        setState(() {

        });
      }


    }

    setState(() {
      _getProductListInProgress == false;
    });
  }
}


import 'package:flutter/material.dart';

import 'custom_ui/pages/add_new_product.dart';
import 'custom_ui/pages/product_list.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Crud App"),
      ),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
          onPressed: (){
            Navigator.pushNamed(context, AddNewProduct.name);
          },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}

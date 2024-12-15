import 'package:flutter/material.dart';
import 'custom_ui/pages/add_new_product.dart';
import 'custom_ui/pages/update_product.dart';
import 'home_page.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: false,
      ),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if(settings.name == "/"){
          widget = HomePage();
        }else if(settings.name == AddNewProduct.name){
          widget = AddNewProduct();
        }else if(settings.name == UpdateProduct.name ){
          final Product product = settings.arguments as Product;
          widget = UpdateProduct(product: product);
        }
        return MaterialPageRoute(builder: (context) {
          return widget;
        },);
      },
    );
  }
}


import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../pages/update_product.dart';
class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.product.image ?? ""),
      title:  Text(widget.product.productName ?? ""),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code: ${widget.product.productCode ?? ""}"),
          Text("Quantity: ${widget.product.quantity ?? ""}"),
          Text("Price: ${widget.product.unitPrice ?? ""}"),
          Text("Total Price: ${widget.product.totalPrice ?? ""}"),

        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.delete,)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, UpdateProduct.name, arguments: widget.product);
          }, icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}

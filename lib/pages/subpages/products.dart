import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/pages/subpages/product.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  const Products({ Key? key }) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {

    final products = Provider.of<List<ProductModel>>(context);
    
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return ProductsTile(product: products[index]);
        }
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/pages/subpages/cart.dart';
import 'package:flutter_applicationtest/pages/subpages/products.dart';
import 'package:flutter_applicationtest/services/auth.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class Selection extends StatelessWidget {
  const Selection({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _showCartPopup(){
      showModalBottomSheet(context: context, builder: (context) {
          return const Cart();
        }
      );
    }
     
    return StreamProvider<List<ProductModel>>.value(
      value: DataService().products, 
      //catchError: (_,__) [],
      initialData: [],
      child: Scaffold (
        body: const Center(
          child: Products()),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showCartPopup();
            },
            child: const Icon(Icons.shopping_basket),
          ),
      )
    );
     

  }
}
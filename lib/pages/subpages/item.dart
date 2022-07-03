import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/product.dart';

class Item extends StatelessWidget {

  final ProductModel cartItem;
  Item({required this.cartItem});

  @override
  Widget build(BuildContext context) {


    return Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 0, 0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(cartItem.imgURL),
                backgroundColor: Colors.white
              ),
              title: Text(cartItem.name),
              subtitle: Text("${cartItem.price}€"),
            )
          )
    );
  }
}
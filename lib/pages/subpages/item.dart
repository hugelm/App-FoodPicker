import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:provider/provider.dart';

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
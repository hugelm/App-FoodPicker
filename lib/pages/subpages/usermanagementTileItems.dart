import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/product.dart';

class UsermanagementTileItem extends StatelessWidget {

  final ProductModel cartItem;
  UsermanagementTileItem({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.description);
  }
}
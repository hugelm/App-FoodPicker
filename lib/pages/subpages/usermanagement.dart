import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/pages/subpages/usermanagementTile.dart';
import 'package:provider/provider.dart';

class Usermanagement extends StatefulWidget {
  const Usermanagement({ Key? key }) : super(key: key);

  @override
  State<Usermanagement> createState() => _UsermanagementState();
}

class _UsermanagementState extends State<Usermanagement> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<CartModel>>(context);

    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          return UsermanagementTile(userProfile: users[index]);
        }
    );    
  }
}
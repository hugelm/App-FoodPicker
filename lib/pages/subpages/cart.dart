import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/pages/loading.dart';
import 'package:flutter_applicationtest/pages/subpages/item.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({ Key? key }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  Widget build(BuildContext context) {

        final user = Provider.of<UserModel>(context);

        return StreamBuilder<List<ProductModel>>(
          stream: DataService(UID: user.UID).cartAll,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<ProductModel>? userCart = snapshot.data;
              return StreamBuilder<CartModel>(
              stream: DataService(UID: user.UID).cart,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  CartModel? userProfile = snapshot.data;
                  return Scaffold (
                    appBar: AppBar(
                    title: const Text("Deine Bestellung")),
                    body: ListView.builder(
                              itemCount: userCart?.length,
                              itemBuilder: (context, index){
                                return StreamProvider<List<ProductModel>>.value(
                                  value: DataService().products, 
                                  //catchError: (_,__) [],
                                  initialData: [],
                                  child: Item(cartItem: userCart![index]),
                                );
                              }
                    ),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () async {
                          await DataService(UID: user.UID).updateCart(userProfile!.username, userProfile.balance,[]);
                          await DataService(UID: user.UID).deleteCart();
                          Navigator.pop(context);
                      },                   
                      child: const Icon(Icons.done),
                    ),
                  );
                } else {
                    return const Loading();
                }
            },
          );
          
      } else {
                    return const Loading();
                } }
      
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class ProductsTile extends StatelessWidget {

  final ProductModel product;
  ProductsTile({required this.product});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    void _showToast(BuildContext context) {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          backgroundColor: Colors.greenAccent,
          content: Text('${product.name} wurde hinzugefügt. Gude!'),
          action: SnackBarAction(
              textColor: Colors.white,
              label: 'Alles klar!',
              onPressed:scaffold.hideCurrentSnackBar,
          ),
        ),
      );
    }

    return StreamBuilder<CartModel>(
          stream: DataService(UID: user.UID).cart,
          builder: (context, snapshot) {
            CartModel? userCart = snapshot.data;
            return Container(
              child: Column(
              children: [
                Center(
                child: Card(
                  elevation: 50,
                  shadowColor: Colors.black,
                  color: Colors.grey[100],
                  child: SizedBox(
                    width: 400,
                    height: 450,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 108,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(product.imgURL),
                              radius: 100,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            product.price.toString() + " €",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () async {                                    
                                  await DataService(UID: user.UID).updateCart(userCart!.username, userCart.balance - product.price, userCart.cart+[product.name]);
                                  var data = {'name': product.name, 'price': product.price, 'imgURL': product.imgURL};
                                  await FirebaseFirestore.instance.collection('profile').doc(user.UID).collection("cart").add(data);
                                  //collection 
                                        //.add(data);
                                        //.then((_) => print('Added'))
                                        //.catchError((error) => print('Add failed: $error'));
                                  _showToast(context);
                                  },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: const [
                                    Icon(Icons.add_shopping_cart),
                                    Text("einpacken!")
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),


            
    ]));

  });
}}
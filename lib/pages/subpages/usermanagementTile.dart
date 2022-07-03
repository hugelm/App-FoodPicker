import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class UsermanagementTile extends StatelessWidget {

  final CartModel userProfile;
  UsermanagementTile({required this.userProfile});

  @override
  Widget build(BuildContext context) {

      final user = Provider.of<UserModel>(context);

      return StreamBuilder<List<ProductModel>>(
          stream: DataService(UID: user.UID).cartAll,
          builder: (context, snapshot) {
            List<ProductModel>? userCart = snapshot.data;
            return Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                    child: Column (
                      children: [
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 25.0,
                              backgroundImage: AssetImage("assets/icons/user.png"),
                              backgroundColor: Colors.white
                            ),
                            title: Text(userProfile.username),
                            //trailing: const Icon(Icons.shopping_cart),
                            subtitle: (Text("letzte Aktivität: ${userProfile.timestamp}")),
                            ),
                            SizedBox(
                              height: 28.0 * (userProfile.cart.length),
                              width: 450,
                              child: ListView.builder(
                              itemCount: userProfile.cart.length,
                              itemBuilder: (context, index){
                                return Card(
                                  color: Colors.grey[100],
                                  child: Text(" • ${userProfile.cart[index]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Open Sans',
                                      fontSize: 16),
                                  )                                 
                                );
                              }),
                            ),                          
                      ]
                  )
            ));
    });

}}
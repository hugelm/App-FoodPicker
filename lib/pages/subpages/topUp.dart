import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/pages/loading.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class TopUp extends StatefulWidget {
  const TopUp({ Key? key }) : super(key: key);
  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {

  final _formKey = GlobalKey<FormState>();
  final List<num> topupAmounts = [5,10,15,20,30,50];
  num? _selectedAmount;


  @override
  Widget build(BuildContext context) {

      final user = Provider.of<UserModel>(context);

      return StreamBuilder<CartModel>(
        stream: DataService(UID: user.UID).cart,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            CartModel? userCart = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text("Wähle einen Betrag:", style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add)
                    ),
                    items: topupAmounts.map((topupAmount) {
                        return DropdownMenuItem(
                          value: topupAmount,
                          child: Text("${topupAmount}€ aufladen"));
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedAmount = val as num),
                  ),
                  const SizedBox(height: 20),
                  RaisedButton(
                    child: const Text("Jetzt Aufladen!"),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        await DataService(UID: user.UID).updateCart(userCart!.username, userCart.balance + (_selectedAmount ?? 0), userCart.cart);
                        Navigator.pop(context);
                      }
                    })

                ],
              ));
          } else {
              return const Loading();
          }
        }
      );
}
}
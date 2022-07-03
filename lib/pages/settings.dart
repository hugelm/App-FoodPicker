import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/pages/loading.dart';
import 'package:flutter_applicationtest/pages/subpages/topUp.dart';
import 'package:flutter_applicationtest/services/auth.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class SettingsUser extends StatefulWidget {
  const SettingsUser({ Key? key }) : super(key: key);

  @override
  State<SettingsUser> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsUser> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? _currentName;

  @override
  Widget build(BuildContext context) {

        final user = Provider.of<UserModel>(context);

        void _topupPopup(){
          showModalBottomSheet(context: context, builder: (context) {
              return const TopUp();
            }
          );
        }

        void _showToast(BuildContext context) {
          final scaffold = Scaffold.of(context);
          scaffold.showSnackBar(
            SnackBar(
              backgroundColor: Colors.greenAccent,
              content: const Text('Dein Nutzername wurde geändert!'),
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
            if(snapshot.hasData){
              CartModel? userCart = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const Text("Dein Nutzername:", style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: userCart?.username,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle)
                      ),
                      validator: (val) => val!.isEmpty ? "Bitte gib einen Nutzernamen an." : null,
                      onChanged: (val) => setState(() => _currentName = val)
                    ),
                    const SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.green,
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                      child: Text("Aktualisieren"),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          await DataService(UID: user.UID).updateCart(_currentName ?? userCart!.username, userCart!.balance, userCart.cart);
                          _showToast(context);
                        }
                      }
                    ),
                    const SizedBox(height: 20),
                    const Text("Dein Kontostand: ", style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 10),
                    Text("${userCart!.balance.toStringAsFixed(2)}€", style: const TextStyle(fontSize: 18),),
                    const SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.green,
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                      child: const Text("Aufladen"),
                      onPressed: () async {
                        _topupPopup();
                      }),
                    const SizedBox(height: 20),
                    const Text("Schon satt?", style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.green,
                      shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                      child: const Text("Ausloggen"),
                      onPressed: () async {
                        await _auth.signOut();
                      }),
                    //Image.network("https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fcdn.shopify.com%2Fs%2Ffiles%2F1%2F0270%2F8747%2F0663%2Fproducts%2Fpick-your-food.001_1200x1200.jpg%3Fv%3D1593630626&f=1&nofb=1"),
                  ],
                ));
            } else {
                return const Loading();
            }
          }
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/pages/shop.dart';
import 'package:flutter_applicationtest/pages/course.dart';
import 'package:flutter_applicationtest/pages/settings.dart';
import 'package:flutter_applicationtest/pages/subpages/cart.dart';
import 'package:flutter_applicationtest/pages/subpages/topUp.dart';
import 'package:flutter_applicationtest/services/auth.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_applicationtest/model/user.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);
  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  final AuthService _auth = AuthService();
  int selectedTab = 1;
  List pages = [
    const Course(),
    const Selection(),
    const SettingsUser()
  ];
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    
    void _topupPopup(){
      showModalBottomSheet(context: context, builder: (context) {
          return const TopUp();
        }
      );
    }

    void _showCartPopup(){
      showModalBottomSheet(context: context, builder: (context) {
          return const Cart();
        }
      );
    }

    return StreamProvider<CartModel>.value(
        value: DataService().cart, 
        //catchError: (_,__) [],
        initialData: CartModel(timestamp: "", username: "", balance: 0, cart: []),
        child: Scaffold (
        appBar: AppBar(
          title: const Text("Food Picker"),
          actions: [
            IconButton(
              onPressed: () {
                _showCartPopup();
            },
            icon: const Icon(Icons.shopping_cart_checkout)),
            IconButton(
              onPressed: () async {
                _topupPopup();
            },
            icon: const Icon(Icons.payment)),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              }, 
              icon: const Icon(Icons.logout)),
          ],
          backgroundColor: Colors.blue,
        ),
        body: pages[selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: selectedTab,
          onTap: (index) => setState(() => selectedTab = index),
          iconSize: 30,
          selectedFontSize: 20,
          unselectedFontSize: 14,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Bestellliste",
              backgroundColor: Colors.blueAccent,
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store),
              label: "Snacks",
              backgroundColor: Colors.blue,
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account",
              backgroundColor: Colors.blueAccent,
              ),
          ],
        ),
        ),      
    );
  }
}
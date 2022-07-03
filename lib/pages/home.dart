import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/pages/subpages/products.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [   
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        //child: Image.asset('assets/icons/search.svg'),
                      ),
                    ),
                  ),
                ),
 
                SizedBox(height: 10),
                //Groceries(),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset('assets/images/apples.png'),
                    ),
                    Expanded(
                      child: Image.asset('assets/images/bananas.png'),

                    ),
                  ],
                ),
                              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset('assets/images/coca_cola.png'),
                    ),
                    Expanded(
                      child: Image.asset('assets/images/sprite.png'),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                SizedBox(height: 10),

                SizedBox(height: 10),


              ],
            ),
          ),
        ),
    );
  }
}
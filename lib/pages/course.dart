import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/pages/subpages/usermanagement.dart';
import 'package:flutter_applicationtest/services/data.dart';
import 'package:provider/provider.dart';

class Course extends StatelessWidget {
  const Course({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void _showDeliveryDoneConfirmation(){
      showModalBottomSheet(context: context, builder: (context) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const Text("Alle versorgt?"),
          );
        }
      );
    }
     
    return StreamProvider<List<CartModel>>.value(
      value: DataService().carts, 
      //catchError: (_,__) [],
      initialData: [],
      child: const Scaffold (
        body: Usermanagement(),
      )
    );
  }
}
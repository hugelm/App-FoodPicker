import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_applicationtest/model/cart.dart';
import 'package:flutter_applicationtest/model/product.dart';
class DataService {

  final String? UID;
  DataService({ this.UID });

  final CollectionReference cartCollection = FirebaseFirestore.instance.collection("profile");

  Future createCart(String email, List cart) async {
    return await cartCollection.doc(UID).set({
      'timestamp': DateTime.now().toString(),
      'user': email, 
      'balance': 0,
      'cart': cart,
    });
  }

  Future updateCart(String? name, num newBalance, List? cart) async {
    return await cartCollection.doc(UID).set({
      'timestamp': DateTime.now().toString(),
      'user': name.toString(), 
      'balance': double.parse(newBalance.toStringAsFixed(2)),
      'cart': cart,
    });
  }

  deleteCart() {
    cartCollection.doc(UID).collection("cart").get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
      }
    });
  }
  
  List<CartModel> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return CartModel(
        timestamp: (doc.data() as dynamic)['timestamp'].toString().substring(0,16),
        username: (doc.data() as dynamic)['user']?? "*no user*", 
        balance: (doc.data() as dynamic)['balance']?? 0, 
        cart: (doc.data() as dynamic)['cart'] ?? "leer"
        );
    }).toList();
  }

  CartModel _userCartFromSnapshot(DocumentSnapshot snapshot){
    return CartModel(
      timestamp: snapshot['timestamp'], 
      username: snapshot['user'], 
      balance: snapshot['balance'], 
      cart: snapshot['cart']);
  }

  List<ProductModel> _userCartAllFromSnapshot(QuerySnapshot snapshot){
      return snapshot.docs.map((doc){
        return ProductModel(
          name: (doc.data() as dynamic)['name']?? "",
          price: (doc.data() as dynamic)['price']?? 0.00, 
          description: (doc.data() as dynamic)['description']?? "",
          imgURL: (doc.data() as dynamic)['imgURL']?? "", 
          );
    }).toList();
  }

  // all users stream
  Stream<List<CartModel>> get carts {
    return cartCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  // user cart stream
  Stream<CartModel> get cart {
    return cartCollection.doc(UID).snapshots()
      .map(_userCartFromSnapshot);
  }

  Stream<List<ProductModel>> get cartAll {
    return cartCollection.doc(UID).collection("cart").snapshots()
      .map(_userCartAllFromSnapshot);
  }

  final CollectionReference productCollection = FirebaseFirestore.instance.collection("products");

  List<ProductModel> _productsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return ProductModel(
        name: (doc.data() as dynamic)['name']?? "",
        price: (doc.data() as dynamic)['price']?? 0.00, 
        description: (doc.data() as dynamic)['description']?? "",
        imgURL: (doc.data() as dynamic)['imgURL']?? "", 
        );
    }).toList();
  }

  Stream<List<ProductModel>> get products {
    return productCollection.snapshots()
      .map(_productsListFromSnapshot);
  }

}
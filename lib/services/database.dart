import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_empleo/models/products_model.dart';

class Database {
  final Firestore _firestore = Firestore.instance;

  Stream<List<Products>> get products {
    return _firestore
        .collection("products")
        .orderBy('price', descending: true)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.documents
            .map((DocumentSnapshot documentSnapshot) => Products(
                name: documentSnapshot.data['name'],
                description: documentSnapshot.data['description'],
                price: documentSnapshot.data['price'],
                id: documentSnapshot.data['id'],
                stock: documentSnapshot.data['stock']))
            .toList());
  }
}

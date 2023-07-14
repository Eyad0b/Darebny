import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/category_model.dart';

class CategoryProvider extends ChangeNotifier {

  Stream<QuerySnapshot> getCategories() {
    return FirebaseFirestore.instance.collection('Categories').snapshots();
  }

  Future<Category> getCategoryById(String categoryId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Categories').doc(categoryId).get();
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return Category(
      name: data['name'] ?? "null",
      imageUrl: data['imageUrl'] ?? "null",
      documentId: snapshot.id,
    );
  }
}

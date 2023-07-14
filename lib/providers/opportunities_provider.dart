import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/opportunity_model.dart';

class OpportunitiesProvider extends ChangeNotifier {

  Future<List<Opportunity>> getOpportunities() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Opportunities').get();
    List<Opportunity> opportunities = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      print('Opportunities: ${data}');
      return Opportunity(
        title: data['title'] ?? "null",
        supTitle: data['supTitle'] ?? "null",
        address: data['address'] ?? "null",
        companyImageUrl: data['companyImageUrl'] ?? "null",
        requirements: data['requirements'] ?? "null",
        description: data['description'] ?? "null",
        date: data['date'],
        backgroundImageUrl: data['backgroundImageUrl'] ?? "null",
        category1: data["category1"] ?? "null",
        category2: data["category2"] ?? "null",
        documentId: document.id,
      );
    }).toList();
    return opportunities;
  }
}
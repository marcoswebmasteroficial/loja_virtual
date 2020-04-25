import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/titles/category_title.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return ListView(
            children: ListTile.divideTiles(
                    context: context,
                    tiles: snapshot.data.documents.map((doc) {
                      return CategoryTitle(doc);
                    }).toList(),
                    color: Colors.grey[500])
                .toList(),
          );
      },
    );
  }
}

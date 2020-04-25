import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductData{
  String category;
  String id;
  String title;
  String description;
  List images;
  List sizes;
  double price;

  ProductData.fromDocuments(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    description = snapshot.data["description"];
    images = snapshot.data["images"];
    sizes = snapshot.data["sizes"];
    price = snapshot.data["price"];
  }

  Map<String , dynamic> toResumedMap(){
    return {
    "title":title,
    "price":price,
  };
  }

}
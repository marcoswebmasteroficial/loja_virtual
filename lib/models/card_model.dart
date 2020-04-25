import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CardModel extends Model {
  UserModel user;
  bool isLoading = false;
  String coupomCode;
  int discountPercentege = 0;

  static CardModel of(BuildContext context) =>
      ScopedModel.of<CardModel>(context);
  List<CardProduct> produtcs = [];

  CardModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  void addCardProduct(CardProduct cardProduct) {
    produtcs.add(cardProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cardProduct.toMap())
        .then((doc) {
      cardProduct.cid = doc.documentID;
      notifyListeners();
    });
  }

  void removeCardItem(CardProduct cardProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cardProduct.cid)
        .delete();
    produtcs.remove(cardProduct);
    notifyListeners();
  }

  void decProduct(CardProduct cardProduct) {
    cardProduct.quantity--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cardProduct.cid)
        .updateData(cardProduct.toMap());
    notifyListeners();
  }

  void inProduct(CardProduct cardProduct) {
    cardProduct.quantity++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cardProduct.cid)
        .updateData(cardProduct.toMap());
    notifyListeners();
  }

  void setCoupon(String coupomCode, int discountPercentege) {
    this.coupomCode = coupomCode;
    this.discountPercentege = discountPercentege;
  }
void updatePrices(){
   notifyListeners();
}
  double getProductsPrice() {
    double price = 0.0;
    for (CardProduct p in produtcs) {
      if (p.productData != null) price += p.quantity * p.productData.price;
    }
    return price;
  }

  double getDiscont() {
    return getProductsPrice() * discountPercentege / 100;
  }

  double getShipPrice() {
    return 1.00;
  }

 Future<String>finishOrder() async{
    if(produtcs.length == 0) return null;
    isLoading = true;
    notifyListeners();
    double productsPrice = getProductsPrice();
    double discount = getDiscont();
    double shipPrice = getShipPrice();

  DocumentReference refOrder = await Firestore.instance.collection("orders").add({
      "clientId" : user.firebaseUser.uid,
      "products" : produtcs.map((cartProduct)=>cartProduct.toMap()).toList(),
      "shipPrice" : shipPrice,
      "productsPrice" : productsPrice,
      "discount" : discount,
      "TotalPrice" : productsPrice - discount + shipPrice,
      "status" : 1,
    });
 await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).setData({
    "orderID" : refOrder.documentID,
  });
QuerySnapshot query = await  Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("carts").getDocuments();
for(DocumentSnapshot doc in query.documents){
doc.reference.delete();
}
produtcs.clear();
coupomCode = null;
discountPercentege = 0;
    isLoading = false;
    notifyListeners();
    return refOrder.documentID;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    produtcs =
        query.documents.map((doc) => CardProduct.fromDocuments(doc)).toList();
    notifyListeners();
  }
}

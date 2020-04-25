import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/models/card_model.dart';


class CardTitle extends StatelessWidget {
  final CardProduct cardProduct;

  CardTitle(this.cardProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContainer() {
      CardModel.of(context).updatePrices();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              cardProduct.productData.images[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    cardProduct.productData.title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Opção: ${cardProduct.size}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'R\$ : ${cardProduct.productData.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.remove,color:  cardProduct.quantity > 1  ? Theme.of(context).primaryColor : Colors.grey[100],), onPressed: cardProduct.quantity > 1 ? (){
                        CardModel.of(context).decProduct(cardProduct);
                      } : null ),
                      Text(cardProduct.quantity.toString()),
                      IconButton(icon: Icon(Icons.add,color: Theme.of(context).primaryColor), onPressed: () {
                        CardModel.of(context).inProduct(cardProduct);
                      }),
                      FlatButton(
                        child: Text('Remove Item',style: TextStyle(color: Colors.grey[500]),),
                        onPressed: () {
                          CardModel.of(context).removeCardItem(cardProduct);
                        },
                      )
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      );
    }

    ;
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cardProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: Firestore.instance
                    .collection("products")
                    .document(cardProduct.category)
                    .collection("items")
                    .document(cardProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cardProduct.productData =
                        ProductData.fromDocuments(snapshot.data);
                    _buildContainer();
                  } else {
                    return Container(
                      height: 70.0,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                },
              )
            : _buildContainer());
  }
}

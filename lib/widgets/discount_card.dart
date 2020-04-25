import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/card_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ExpansionTile(
          title: Text(
            'Cupom de Desconto',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          ),
          leading: Icon(Icons.card_giftcard),
          trailing: Icon(Icons.add),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: "Digite Seu Cupom"),
                initialValue: CardModel.of(context).coupomCode ?? "",
                onFieldSubmitted: (text) {
                  Firestore.instance
                      .collection("coupons")
                      .document(text)
                      .get()
                      .then((c) {
                    if (c.data != null) {
                      CardModel.of(context).setCoupon(text, c.data["percent"]);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Desconto ${c.data["percent"]} % aplicado!"),
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    } else {
                      CardModel.of(context).setCoupon(null, 0);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                        Text("Cupom invalido!"),
                        backgroundColor: Colors.redAccent,
                      ));
                    }
                  });
                },
              ),
            )
          ],
        ));
  }
}

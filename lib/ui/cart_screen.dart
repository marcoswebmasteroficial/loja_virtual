import 'package:flutter/material.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/titles/card_title.dart';
import 'package:lojavirtual/ui/login_screen.dart';
import 'package:lojavirtual/ui/order_screen.dart';
import 'package:lojavirtual/widgets/cart_price.dart';
import 'package:lojavirtual/widgets/discount_card.dart';
import 'package:lojavirtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carinho"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CardModel>(
              builder: (context, child, model) {
                int p = model.produtcs.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CardModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Você precisa está logando",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            );
          } else if (model.produtcs == null || model.produtcs.length == 0) {
            return Center(
              child: Text(
                "Nenhum Produto no Carinho!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                    children: model.produtcs.map((item) {
                  return CardTitle(item);
                }).toList()),
                DiscountCard(),
                shipCard(),
                cartPrice(() async {
                  String orderID = await model.finishOrder();
                  if (orderID != null)
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => orderScreen(orderID)));
                })
              ],
            );
          }
          ;
        },
      ),
    );
  }
}

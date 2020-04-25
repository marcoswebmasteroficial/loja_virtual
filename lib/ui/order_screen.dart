import 'package:flutter/material.dart';

class orderScreen extends StatelessWidget {
  @override
  final String OrderId;

  orderScreen(this.OrderId);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado!"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              "Pedido Realizado com Sucesso",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text(
              "Código do Pedido: # ${OrderId}",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

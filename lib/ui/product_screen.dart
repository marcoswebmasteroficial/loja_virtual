import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/card_product.dart';
import 'package:lojavirtual/datas/product_data.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/ui/login_screen.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme
        .of(context)
        .primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return Image.network(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: _primaryColor,
              autoplay: false,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text("R\$  ${product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: _primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Opções",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              color:
                              s == size ? _primaryColor : Colors.grey[500],
                              width: 3.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          width: 50.0,
                          child: Text(s,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: s == size
                                      ? _primaryColor
                                      : Colors.grey[500],
                                  fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: size != null
                        ? () {
                      if (UserModel.of(context).isLoggedIn()) {
                        CardProduct cardProduct = CardProduct();
                        cardProduct.size = size;
                        cardProduct.quantity = 1;
                        cardProduct.pid = product.id;
                        cardProduct.category = product.category;
                        cardProduct.productData = product;
                        CardModel.of(context).addCardProduct(cardProduct);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CardScreen()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    }
                        : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? 'Adicionar Carinho' : 'Faça login para comprar',
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                    color: _primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Descrição",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

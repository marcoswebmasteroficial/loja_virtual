import 'package:flutter/material.dart';
import 'package:lojavirtual/tabs/home_tab.dart';
import 'package:lojavirtual/tabs/orders_tab.dart';
import 'package:lojavirtual/tabs/places_tab.dart';
import 'package:lojavirtual/tabs/products_tab.dart';
import 'package:lojavirtual/widgets/cart_button.dart';
import 'package:lojavirtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: Drawer(
            child: CustomDrawer(_pageController),
          ),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Produtos'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: Drawer(
            child: CustomDrawer(_pageController),
          ),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Localização Lojas'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: Drawer(
            child: CustomDrawer(_pageController),
          ),
          body: PlacesTab(),

        ),
        Scaffold(
          appBar: AppBar(
            title: const Text('Meus Pedidos'),
            backgroundColor: Colors.black,
            centerTitle: true,
          ),
          drawer: Drawer(
            child: CustomDrawer(_pageController),
          ),
          body: OrdersTab(),

        ),

      ],
    );
  }
}

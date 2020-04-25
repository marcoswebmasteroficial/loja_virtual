import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:lojavirtual/titles/drawer_title.dart';
import 'package:lojavirtual/ui/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 234, 234, 234),
          Color.fromARGB(255, 173, 169, 150),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildDrawerBack(),
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 160.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        'Ai Caramba Burguer',
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Olá, ${!model.isLoggedIn() ? '' : model.userData["name"]}',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                child: Text(!model.isLoggedIn() ? 'Entre ou Cadastre-se >' : 'Sair',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18.0)),
                                onTap: () {
                                  if(!model.isLoggedIn())
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => LoginScreen())
                                    );
                                else
                                  model.signOut();

                                },
                              ),
                            ],
                          );
                        },

                      )
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 190, 48),
              ),
            ),
            DrawerTitle(Icons.home,"Inicio", pageController,0),
            DrawerTitle(Icons.list,"Produtos", pageController,1),
            DrawerTitle(Icons.location_on,"Lojas", pageController,2),
            DrawerTitle(Icons.playlist_add_check,"Meus Pedidos", pageController,3),
          ],
        )
      ],
    );
  }
}

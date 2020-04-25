import 'package:flutter/material.dart';
import 'package:lojavirtual/models/card_model.dart';
import 'package:lojavirtual/ui/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/user_model.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child:ScopedModelDescendant<UserModel>(
        builder: (context,child,model){
          return ScopedModel<CardModel>(
            model: CardModel(model),
            child:  MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.yellow,
                primaryColor: Colors.black,
                brightness: Brightness.light,
              ),
              home: HomeScreen(),
            ),
          );
        },
      )
    );
  }
}
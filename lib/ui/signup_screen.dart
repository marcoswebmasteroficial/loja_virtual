import 'package:flutter/material.dart';
import 'package:lojavirtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _Formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController  = TextEditingController();
  final _addressController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Acessar Conta',
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              onPressed: () {},
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading) return Center(child: CircularProgressIndicator(),);
            return Form(
              key: _Formkey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Nome Completo",
                    ),
                    validator: (text) {
                      if (text.isEmpty) return "Nome Inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail Inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: "Endereço",
                    ),
                    validator: (text) {
                      if (text.isEmpty) return "Endereço Inválido";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Inválida";
                    },
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_Formkey.currentState.validate()) {
                          Map<String , dynamic> userData = {
                            "name" : _nameController.text,
                            "email" : _emailController.text,
                            "address" : _addressController.text,
                          };
                          model.signUp(userData: userData, pass: _passwordController.text, OnSucess: _OnSucess, OnFail: _OnFail);
                        }
                      },
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
  void _OnSucess(){
_scaffoldKey.currentState.showSnackBar(
  SnackBar(content: Text("Usuario Cadastrado com Sucesso!"),
  backgroundColor: Colors.green,
  duration: Duration(seconds: 2),)
);
Future.delayed(Duration(seconds: 2)).then((s) {
  Navigator.of(context).pop();
});
  }
  void _OnFail(){
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Error Cadastrado!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),)
    );
  }
}






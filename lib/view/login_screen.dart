import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:evento_app/controller/user_controller.dart';
import 'package:evento_app/model/user.dart';
import 'package:evento_app/view/event_screen.dart';
import 'package:evento_app/view/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _senha = new TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(
          "NOSSO EVENTO",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Flexible(
                    flex: 1,
                    child: Center(
                        child: Image.asset("assets/images/logo.png",
                            width: 150.0, height: 150.0))),
                Flexible(
                  child: TextFormField(
                    maxLength: 100,
                    decoration: InputDecoration(hintText: "E-mail"),
                    controller: _email,
                    keyboardType: TextInputType.text,
                    validator: (val) => val == "" ? val : null,
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    obscureText: true,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: "Senha"),
                    controller: _senha,
                    keyboardType: TextInputType.text,
                    validator: (val) => val == "" ? val : null,
                  ),
                ),
                Flexible(
                  child: FlatButton(
                    color: Colors.deepPurple,
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _login(context, globalKey);
                    },
                  ),
                ),
                Flexible(
                  child: FlatButton(
                    child: Text("Cadastrar"),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => SignUpScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _login(BuildContext context, GlobalKey<ScaffoldState> globalKey) async {
    User user = User("", _email.text, _convertToMd5(_senha.text));
    if (formKey.currentState.validate()) {
      ApiResponse response = await UserController().login(user, formKey);
      if (response != null) {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text(response.msg),
        ));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => EventScreen()));
      } else {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Não foi possível realizar o login"),
        ));
      }
    } else {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text("Preencha os campos em branco"),
      ));
    }
  }

  String _convertToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
}

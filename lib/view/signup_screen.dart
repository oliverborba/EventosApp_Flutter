import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:evento_app/controller/user_controller.dart';
import 'package:evento_app/model/user.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nome = new TextEditingController();
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
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: 150.0,
                      height: 150.0,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: "Nome",
                      ),
                      controller: _nome,
                      keyboardType: TextInputType.text,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                      ),
                      controller: _email,
                      keyboardType: TextInputType.text,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      maxLength: 20,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Senha",
                      ),
                      controller: _senha,
                      keyboardType: TextInputType.text,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => {_cadastroUsuario(globalKey)},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple, // Background Colorq
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _cadastroUsuario(GlobalKey<ScaffoldState> globalKey) async {
    User user = User(_nome.text, _email.text, _convertToMd5(_senha.text));
    if (formKey.currentState.validate()) {
      ApiResponse response =
          await UserController().adicionarParticipante(user, formKey);
      if (response != null) {
        globalKey.currentState
            .showSnackBar(SnackBar(content: Text(response.msg)));
      } else {
        globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Não foi possível cadastrar usuário."),
        ));
      }
    } else {
      globalKey.currentState.showSnackBar(SnackBar(
        content: Text("Preencha os campos em branco."),
      ));
    }
  }

  String _convertToMd5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }
}

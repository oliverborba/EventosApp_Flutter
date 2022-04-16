import 'package:evento_app/view/activity_screen.dart';
import 'package:evento_app/view/event_screen.dart';
import 'package:evento_app/view/login_screen.dart';
import 'package:flutter/material.dart';

import '../controller/user_controller.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
        children: [
          _header("Anne Caroline"),
          ListTile(
            title: Text("Agenda"),
            leading: Icon(Icons.today),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => EventScreen()));
            },
          ),
          ListTile(
            title: Text("Atividades"),
            leading: Icon(Icons.today),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ActivityScreen()));
            },
          ),
          ListTile(
            title: Text("Sair"),
            leading: Icon(Icons.exit_to_app),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              UserController().logout();
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen()));
            },
          )
        ],
      )),
    );
  }

  Widget _header(String nome) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple),
      accountName: Text(nome),
      accountEmail: Text("lucas@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 80,
        child: Text(
          "A",
          style: TextStyle(fontSize: 40.0, color: Colors.black54),
        ),
      ),
    );
  }
}

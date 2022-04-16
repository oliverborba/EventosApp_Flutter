import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserController extends StatefulWidget {
  @override
  _UserControllerState createState() => _UserControllerState.instance;

  Future<ApiResponse> adicionarParticipante(
      User user, GlobalKey<FormState> formKey) {
    return createState()._cadastrar(user, formKey);
  }

  Future<ApiResponse> login(User user, GlobalKey<FormState> formKey) {
    return createState()._login(user, formKey);
  }

  Future<void> logout() {
    return createState()._logout();
  }
}

class _UserControllerState extends State<UserController> {
  String firebaseUserUid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  static _UserControllerState _instance;

  _UserControllerState._() {}

  static _UserControllerState get instance =>
      _instance = _instance ?? _UserControllerState._();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> _logout() async {
    await _auth.signOut();
  }

  Future<ApiResponse> _login(User user, GlobalKey<FormState> formKey) async {
    try {
      formKey.currentState.save();
      formKey.currentState.reset();
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return ApiResponse.ok(msg: "Você realizou login com sucesso!");
    } catch (error) {
      print(error);
      return ApiResponse.error(msg: "Não foi possível realizar o login!");
    }
  }

  Future<ApiResponse> _cadastrar(
      User user, GlobalKey<FormState> formKey) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      final FirebaseUser fUser = result.user;

      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = user.name;
      fUser.updateProfile(userUpdateInfo);

      if (fUser != null) {
        firebaseUserUid = fUser.uid;
        DocumentReference refUser =
            Firestore.instance.collection("user").document(firebaseUserUid);
        refUser.setData({
          "name": user.name,
          "email": user.email,
          "password": user.password
        });
      }

      formKey.currentState.save();
      formKey.currentState.reset();

      return ApiResponse.ok(msg: "Usuário cadastrado com sucesso");
    } catch (error) {
      print(error);
      if (error is PlatformException) {
        print("Error Code ${error.code}");

        return ApiResponse.error(
            msg:
                "Erro ao cadastrar usuário.\n\n Este email já se encontra em nosso sistema");
      }
      return ApiResponse.error(msg: "Não foi possével criar um usuário.");
    }
  }
}

class ApiResponse<T> {
  bool ok;
  String msg;
  T result;

  ApiResponse.ok({this.result, this.msg}) {
    ok = true;
  }

  ApiResponse.error({this.result, this.msg}) {
    ok = false;
  }
}

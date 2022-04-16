import 'package:evento_app/service/firebase_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:evento_app/controller/activity_controller.dart';

class ActivityController extends StatefulWidget {
  @override
  _ActivityControllerState createState() => _ActivityControllerState.instance;

  DatabaseReference getAllActivities(String table) {
    return createState()._getAllActivities(table);
  }

  void addActivity(String table, Object data) {
    createState()._addActivity(table, data);
  }

  void deleteActivity(String table, Object data) {
    createState()._deleteActivity(table, data);
  }
}

class _ActivityControllerState extends State<ActivityController> {
  FirebaseService firebaseService = FirebaseService();
  static _ActivityControllerState _instance;

  _ActivityControllerState._() {}

  static _ActivityControllerState get instance =>
      _instance ?? _ActivityControllerState._();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _addActivity(String table, Object data) {
    firebaseService.saveDatabaseRealTime(table, data);
  }

  void _deleteActivity(String table, Object data) {
    firebaseService.deleteDatabaseRealTime(table, data);
  }

  DatabaseReference _getAllActivities(String table) {
    return firebaseService.getDataRealTime(table);
  }
}

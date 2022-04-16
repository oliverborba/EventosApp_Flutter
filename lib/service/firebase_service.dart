import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final FirebaseDatabase databaseRealTime = FirebaseDatabase();
  DatabaseReference databaseReference;

  DatabaseReference getDataRealTime(String databaseName) {
    return databaseReference = databaseRealTime.reference().child(databaseName);
  }

  void saveDatabaseRealTime(String databaseName, dynamic model) {
    databaseReference = databaseRealTime.reference().child(databaseName);
    databaseReference.push().set(model.toJson());
  }

  void updateDatabaseRealTime(String databaseName, dynamic model) {
    databaseReference = databaseRealTime.reference().child(databaseName);
    databaseReference.update(model.toJson());
  }

  void deleteDatabaseRealTime(String databaseName, dynamic key) {
    // ignore: deprecated_member_use
    databaseReference = databaseRealTime.reference().child(databaseName);
    databaseReference.child(key).remove();
  }
}

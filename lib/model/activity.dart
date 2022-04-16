import 'package:firebase_database/firebase_database.dart';

class Activity {
  String key;
  String title;
  String speaker;
  String schedule;
  bool confirmed;

  Activity(this.title, this.speaker, this.schedule, this.confirmed);

  Activity.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        speaker = snapshot.value["speaker"],
        schedule = snapshot.value["schedule"],
        confirmed = snapshot.value["title"];

  toJson() {
    return {
      "title": title,
      "speaker": speaker,
      "schedule": schedule,
      "confirmed": confirmed,
    };
  }

  Activity.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    title = json["speaker"];
    title = json["schedule"];
    title = json["confirmed"];
  }
  void setKey(String value) {
    key = value;
  }
}

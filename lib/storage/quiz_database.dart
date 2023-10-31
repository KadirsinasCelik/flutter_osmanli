import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/model_soru.dart';

class QuizDatabase {
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseFirestore storage = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance; 

  Future<List<Soru>> getQuestions(String donem) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("sorular/$donem");
    DataSnapshot snapshot = await ref.get();
    List<Soru> data = [];

    if (snapshot.value is List) {
      var values = jsonDecode(jsonEncode(snapshot.value));
      for (int i = 1; i < values.length; i++) {
        var value = values[i] as Map<String, dynamic>;
        Soru soru = Soru.fromJson(value);
        data.add(soru);
      }
    }

    return data;
  }

  Future<int> getQuestionsPoint() async {
    var ref = storage.collection("questions");
    var doc = ref.doc(auth.currentUser!.uid);
    int questionsPoint = 0;
    await doc.get().then((value) {
      if (value.exists) {
        for (var i = 1; i < 6; i++) {
          var point = value.get("$i") as String;
          questionsPoint += int.parse(point);
        }
      }
    });
    return questionsPoint;
  }

  void updateFireStoreQuestionPoints(String donem, String newPoint) {
    var ref = storage.collection("questions");
    var doc = ref.doc(auth.currentUser!.uid);
    doc.get().then((value) {
      if (value.exists) {
        var gameOne = value.get("1") as String;
        var gameTwo = value.get("2") as String;
        var gameThree = value.get("3") as String;
        var gameFour = value.get("4") as String;
        var gameFive = value.get("5") as String;
        switch (donem) {
          case "1":
            gameOne = newPoint;
            break;
          case "2":
            gameTwo = newPoint;
            break;
          case "3":
            gameThree = newPoint;
            break;
          case "4":
            gameFour = newPoint;
            break;
          case "5":
            gameFive = newPoint;
            break;
          default:
        }
        doc.update({
          "1": gameOne,
          "2": gameTwo,
          "3": gameThree,
          "4": gameFour,
          "5": gameFive
        });
      } else {
        var gameOne = "0";
        var gameTwo = "0";
        var gameThree = "0";
        var gameFour = "0";
        var gameFive = "0";
        switch (donem) {
          case "1":
            gameOne = newPoint;
            break;
          case "2":
            gameTwo = newPoint;
            break;
          case "3":
            gameThree = newPoint;
            break;
          case "4":
            gameFour = newPoint;
            break;
          case "5":
            gameFive = newPoint;
            break;
          default:
        }
        doc.set({
          "1": gameOne,
          "2": gameTwo,
          "3": gameThree,
          "4": gameFour,
          "5": gameFive
        });
      }
    });
  }
}

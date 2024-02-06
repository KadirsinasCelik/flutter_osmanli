import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final db = FirebaseFirestore.instance;
final refStorage = FirebaseStorage.instance.ref();

final dbOsmRef = db.collection("periods");

Future<Map<String, dynamic>> databaseGetAllPeriods() async {
  Map<String, dynamic> mapVeri = {};

  try {
    var querySnapshot = await dbOsmRef.get();
    for (var docSnapshot in querySnapshot.docs) {
      mapVeri[docSnapshot.id] = docSnapshot.data();
    }
  } catch (e) {
    log("Error completing: $e");
  }

  return mapVeri;
}

final dbCatRef = db.collection("configuration");

Future<Map<String, dynamic>> databaseGetAllCategories() async {
  var veri = await dbCatRef.doc("categories").get();
  Map<String, dynamic> mapVeri = {};
  mapVeri = veri.data() as Map<String, dynamic>;
  return mapVeri;
}

Future<String> databaseGetPadisahImage(int id) async {
  var image = await refStorage.child("padişahlar/$id.jpg").getDownloadURL();
  return image;
}

final dbOsmPad = db.collection("padisahlar");

Future<Map<String, dynamic>> databaseGetAllPadisahWithPeriod(int period) async {
  Map<String, dynamic> mapVeri = {};

  try {
    var querySnapshot = await dbOsmPad.where("period", isEqualTo: period).get();
    int i = 0;
    for (var docSnapshot in querySnapshot.docs) {
      i = i + 1;
      mapVeri['$i'] = docSnapshot.data();
    }
  } catch (e) {
    log("Error completing: $e");
  }

  return mapVeri;
}



Future<String> databaseGetSadrazamImage(int id) async {
  var image = await refStorage.child("sadrazamlar/$id.jpg").getDownloadURL();
  return image;
}

final dbOsmSad = db.collection("sadrazamlar");

Future<Map<String, dynamic>> databaseGetAllSadrazamWithPeriod(int period) async {
  Map<String, dynamic> mapVeri = {};

  try {
    var querySnapshot = await dbOsmSad.where("period", isEqualTo: period).get();
    int i = 0;
    for (var docSnapshot in querySnapshot.docs) {
      i = i + 1;
      mapVeri['$i'] = docSnapshot.data();
    }
  } catch (e) {
    log("Error completing: $e");
  }

  return mapVeri;
}


Future<String> databaseGetWarImage(int id) async {
  var image = await refStorage.child("savaşlar/$id.jpg").getDownloadURL();
  return image;
}

final dbOsmWar = db.collection("savaslar");

Future<Map<String, dynamic>> databaseGetAllWarWithPeriod(int period) async {
  Map<String, dynamic> mapVeri = {};

  try {
    var querySnapshot = await dbOsmWar.where("period", isEqualTo: period).get();
    int i = 0;
    for (var docSnapshot in querySnapshot.docs) {
      i = i + 1;
      mapVeri['$i'] = docSnapshot.data();
    }
  } catch (e) {
    log("Error completing: $e");
  }
  return mapVeri;
}



Future<String> databaseGetEpochImage(int id) async {
  var image = await refStorage.child("dönem/$id.jpg").getDownloadURL();
  return image;
}

final dbOsmEpoch = db.collection("donemler");
Future<Map<String, dynamic>> databaseGetAllEpochWithPeriod(int period) async {
  Map<String, dynamic> mapVeri = {};

  try {
    var querySnapshot = await dbOsmEpoch.where("period", isEqualTo: period).get();
    int i = 0;
    for (var docSnapshot in querySnapshot.docs) {
      i = i + 1;
      mapVeri['$i'] = docSnapshot.data();
    }
  } catch (e) {
    log("Error completing: $e");
  } 
  return mapVeri;
}


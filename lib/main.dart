import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/firebase_options.dart';
import 'package:flutter_osmanli/pages/admin.dart';
import 'package:flutter_osmanli/pages/tabbar.dart';
import 'package:hive_flutter/adapters.dart';

import 'api/messaging_api.dart';

bool isAdmin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('note_box');
  await Hive.openBox('note_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await checkAdmin(FirebaseAuth.instance).then((value) {
    runApp(const MyApp());
  });
}

Future<bool> checkAdmin(FirebaseAuth value) async {
  var firebaseAuth = value;

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("admins").get();

    if (querySnapshot.docs.isNotEmpty) {
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        if (querySnapshot.docs[i].exists) {
          var data = querySnapshot.docs[i].data();
          if (firebaseAuth.currentUser != null &&
              data.entries.first.value == firebaseAuth.currentUser!.uid) {
            isAdmin = true;
            log("girdi");
            return true;
          } else {
            return false;
          }
        }
      }
    }
  } catch (e) {
  
    log("Error checking admin: $e");
  }

  return false; 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messagingService = MessagingService();

  @override
  void initState() {
    super.initState();
    _messagingService.init(context);
  }

  @override
  Widget build(BuildContext context) {
 
    return MaterialApp(
        title: 'Osmanlı Ansiklopedisi',
        debugShowCheckedModeBanner: false,
        home: isAdmin ? Admin() : const TabbBar());
  }
}

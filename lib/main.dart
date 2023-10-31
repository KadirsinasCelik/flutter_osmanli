import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/firebase_options.dart';
import 'package:flutter_osmanli/pages/tabbar.dart';
import 'package:hive_flutter/adapters.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('shopping_box');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home:  TabbBar());
  }
}

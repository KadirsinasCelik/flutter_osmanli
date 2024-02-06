import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/pages/soru_sayfasi.dart';
import 'package:flutter_osmanli/storage/quiz_database.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

class SoruKategorileri extends StatefulWidget {
  const SoruKategorileri({super.key});

  @override
  State<SoruKategorileri> createState() => _SoruKategorileriState();
}

class _SoruKategorileriState extends State<SoruKategorileri> {
  QuizDatabase? quizDatabase;
  List<int>? questionsPointList = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    quizDatabase = QuizDatabase();
    if(FirebaseAuth.instance.currentUser == null){

    } else {
        questionsPointList = await quizDatabase!.getQuestionsListPoint();
    setState(() {}); // Trigger a rebuild to update the UI with the fetched data
    questionsPointList?.forEach((element) {
      log(element.toString());
    });
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Dönemler  Testleri",
            style: TextStyle(
                fontFamily: "Sacramento",
                fontSize: 30,
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900),
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      backgroundColor: background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  color: Colors.amber,
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    "https://img.freepik.com/premium-vector/quiz-logo-with-speech-bubble-icon_149152-813.jpg",
                    errorBuilder: (context, error, stackTrace) =>
                        const CircularProgressIndicator(),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Container(
                  color: Colors.amber,
                  height: 10,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Card(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Card(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .black; // Basılıyken farklı bir renk
                                  }
                                  return Colors.grey; // Normal durumda renk
                                },
                              ),
                            ),
                            onPressed: () {
                              if (authControl(context)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizPage(donem: "1"),
                                    ));
                              }
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Kuruluş Dönem Testi",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.cyanAccent)),
                                questionsPointList != null &&
                                        questionsPointList!.isNotEmpty
                                    ? questionsPointList![0] != 0
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)
                                    : const Icon(Icons.close)
                              ],
                            ))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Card(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .black; // Basılıyken farklı bir renk
                                  }
                                  return Colors.grey; // Normal durumda renk
                                },
                              ),
                            ),
                            onPressed: () {
                              if (authControl(context)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizPage(donem: "2"),
                                    ));
                              }
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Yükseliş Dönemi Test",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.cyanAccent)),
                                questionsPointList != null &&
                                        questionsPointList!.isNotEmpty
                                    ? questionsPointList![1] != 0
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)
                                    : const Icon(Icons.close)
                              ],
                            ))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Card(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .black; // Basılıyken farklı bir renk
                                  }
                                  return Colors.grey; // Normal durumda renk
                                },
                              ),
                            ),
                            onPressed: () {
                              if (authControl(context)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizPage(donem: "3"),
                                    ));
                              }
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Duraklama Dönemi Test",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.cyanAccent)),
                                questionsPointList != null &&
                                        questionsPointList!.isNotEmpty
                                    ? questionsPointList![2] != 0
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)
                                    : const Icon(Icons.close)
                              ],
                            ))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Card(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .black; // Basılıyken farklı bir renk
                                  }
                                  return Colors.grey; // Normal durumda renk
                                },
                              ),
                            ),
                            onPressed: () {
                              if (authControl(context)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizPage(donem: "4"),
                                    ));
                              }
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Gerileme Dönemi Test",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.cyanAccent)),
                                questionsPointList != null &&
                                        questionsPointList!.isNotEmpty
                                    ? questionsPointList![3] != 0
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)
                                    : const Icon(Icons.close)
                              ],
                            ))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Card(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors
                                        .black; // Basılıyken farklı bir renk
                                  }
                                  return Colors.grey; // Normal durumda renk
                                },
                              ),
                            ),
                            onPressed: () {
                              if (authControl(context)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizPage(donem: "5"),
                                    ));
                              }
                            },
                            child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Dağılma Dönemi Test",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.cyanAccent),
                                ),
                                questionsPointList != null &&
                                        questionsPointList!.isNotEmpty
                                    ? questionsPointList![4] != 0
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.close)
                                    : const Icon(Icons.close)
                              ],
                            ))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool authControl(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("KULLANICI GİRİŞİ YAPILMADAN SORU ÇÖZÜLEMEZ!")));
      return false;
    } else {
      return true;
    }
  }
}

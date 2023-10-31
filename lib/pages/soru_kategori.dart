import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/pages/soru_sayfasi.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

class SoruKategorileri extends StatelessWidget {
  const SoruKategorileri({super.key});

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
                        const CircularProgressIndicator(
                      
                    ),
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
                            child: const Center(
                                child: Text("Kuruluş Dönem Testi",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyanAccent)))),
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
                            child: const Center(
                                child: Text("Yükseliş Dönemi Test",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyanAccent)))),
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
                            child: const Center(
                                child: Text("Duraklama Dönemi Test",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyanAccent)))),
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
                            child: const Center(
                                child: Text("Gerileme Dönemi Test",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyanAccent)))),
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
                            child: const Center(
                                child: Text("Dağılma Dönemi Test",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyanAccent),))),
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

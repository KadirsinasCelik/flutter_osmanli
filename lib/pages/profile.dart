import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/controller/authController.dart';
import 'package:flutter_osmanli/pages/tabbar.dart';
import 'package:flutter_osmanli/storage/quiz_database.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.auth, required this.controller});
  final FirebaseAuth auth;
  final AuthController controller;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late QuizDatabase quizDatabase;
  int point = 0;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      if (widget.auth.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  const TabbBar()));
      }
      quizDatabase = QuizDatabase();
      getQuestionPoint();
    }
  }

  void getQuestionPoint() async {
    quizDatabase.getQuestionsPoint().then((value) {
      setState(() {
        point = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF01ADAD),
          title: const Center(
              child: Text("Profil Bilgi Sayfası",
                  style: TextStyle(
                  //    fontFamily: "Sacramento",
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                     // color: Colors.cyanAccent
                      ))),
          leading: IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  const TabbBar())),
              icon: const Icon(Icons.home)),
          actions: [
            IconButton(
                onPressed: () {
                  widget.controller.SignOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  const TabbBar()));
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(10.0),
            color: Colors.transparent,
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  color: Colors.black38,
                  child: const Icon(
                    color: Colors.cyan,
                    Icons.groups,
                    size: 60,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors.black54,
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        const Text(
                          "  UID :",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "  ${widget.auth.currentUser!.uid}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  color: Colors.black54,
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        const Text(
                          "  Email :",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "  ${widget.auth.currentUser!.email}",
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: Colors.black54,
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        const Text(
                          "  Son Çevrimiçi Anı :",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "  ${widget.auth.currentUser!.metadata.lastSignInTime}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
          /*      Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.insights,
                          size: 30,
                          color: Colors.cyan[100],
                        ),
                        const Text(
                          "Test Skor Durumu",
                          style:
                              TextStyle(fontSize: 20, color: Colors.cyanAccent),
                        ),
                        Icon(
                          Icons.insights,
                          size: 30,
                          color: Colors.cyan[100],
                        ),
                      ],
                    ),
                  ),
                ),*/
                const SizedBox(
                  height: 5,
                ),
                
  /*              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: Colors.black54,
                  child: SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        const Text(
                          "  Toplam Test Skor Sonucunuz :",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w900),
                        ),
                        Text(
                          point.toString()+"/50",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        )
        )
        ;
  }
}

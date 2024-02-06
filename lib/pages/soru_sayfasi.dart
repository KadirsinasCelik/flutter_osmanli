import 'package:flutter/material.dart';
import 'package:flutter_osmanli/utilities/constants.dart';
import 'package:flutter_osmanli/widgets/next_button.dart';
import 'package:flutter_osmanli/storage/quiz_database.dart';
import 'package:flutter_osmanli/widgets/result_box.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.donem});
  final String donem;
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizDatabase quizDB;
  @override
  void initState() {
    quizDB = QuizDatabase();
    super.initState();
  }

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isSelectedTrue = false;
  bool isAlreadySelected = false;

  void nextQuestion(int questionLenght, bool value) {
    if (value) {
      setState(() {
        score += 1;
        if (index == questionLenght - 1) {
        } else {
          showDialog(
  context: context,
  builder: (BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.green, 
      ),
      child: AlertDialog(
        title: const Center(child: Text('Doğru Cevap!',style: TextStyle(color: Color.fromARGB(255, 226, 204, 204),fontStyle: FontStyle.italic),)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Center(child: Text('Kapat',style: TextStyle(color: Colors.black),)),
          ),
        ],
      ),
    );
  },
);
        }
      });
    } else {
      if (index == questionLenght - 1) {
      } else {
            showDialog(
  context: context,
  builder: (BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.red, 
      ),
      child: AlertDialog(
        title: const Center(child: Text('Yanlış Cevap Veya Format',style: TextStyle(color: Color.fromARGB(255, 236, 214, 214),fontStyle: FontStyle.italic))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Center(child: Text('Kapat',style: TextStyle(color: Colors.black))),
          ),
        ],
      ),
    );
  },
);
      }
    }
    if (index == questionLenght - 1) {
      quizDB.updateFireStoreQuestionPoints(widget.donem, score.toString());
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ResultBox(
          onPressed: startOver,
          result: score,
          questionLenght: questionLenght,
        ),
      );
    } else {
      if (isPressed) {
        setState(() {
          index++;

          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Boş Bırakamazsınız!!!'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: quizDB.getQuestions(widget.donem),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                backgroundColor: background,
                title: const Text(
                  'Test Zamanı',
                  style: TextStyle(color: Colors.greenAccent),
                ),
                shadowColor: Colors.red,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Skorunuz: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
              body: Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.cyan,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          width: double.infinity,
                          color: Colors.cyanAccent,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            color: Colors.green,
                            child: Text(
                              snapshot.data![index].title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  wordSpacing: 2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10)),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Card(
                            color: Colors.black,
                            child: InkWell(
                              onTap: () {
                                isPressed = true;
                                if (snapshot.data![index].options.entries
                                    .elementAt(0)
                                    .value) {
                                  isSelectedTrue = true;
                                } else {
                                  isSelectedTrue = false;
                                }
                              },
                              child: Text(
                                snapshot.data![index].options.entries
                                    .elementAt(0)
                                    .key
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    wordSpacing: 2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Card(
                            color: Colors.black,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isPressed = true;
                                  if (snapshot.data![index].options.entries
                                      .elementAt(1)
                                      .value) {
                                    isSelectedTrue = true;
                                  } else {
                                    isSelectedTrue = false;
                                  }
                                });
                              },
                              child: Text(
                                snapshot.data![index].options.entries
                                    .elementAt(1)
                                    .key
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    wordSpacing: 2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Card(
                            color: Colors.black,
                            child: InkWell(
                              onTap: () {
                                isPressed = true;

                                if (snapshot.data![index].options.entries
                                    .elementAt(2)
                                    .value) {
                                  isSelectedTrue = true;
                                } else {
                                  isSelectedTrue = false;
                                }
                              },
                              child: Text(
                                snapshot.data![index].options.entries
                                    .elementAt(2)
                                    .key
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    wordSpacing: 2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          color: Colors.white,
                          width: double.infinity,
                          child: Card(
                            color: Colors.black,
                            child: InkWell(
                              onTap: () {
                                isPressed = true;
                                if (snapshot.data![index].options.entries
                                    .elementAt(3)
                                    .value) {
                                  isSelectedTrue = true;
                                } else {
                                  isSelectedTrue = false;
                                }
                              },
                              child: Text(
                                snapshot.data![index].options.entries
                                    .elementAt(3)
                                    .key
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    wordSpacing: 2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () =>
                    nextQuestion(extractedData!.length, isSelectedTrue),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLenght,
    required this.onPressed,
  }) : super(key: key);

  final int result;
  final int questionLenght;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(fontSize: 30.0);
    return SizedBox(
      height: 100,
      child: AlertDialog(
        backgroundColor: background,
        content: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sonucunuz',style: TextStyle(fontSize: 30,fontFamily: "Sacramento",fontWeight:FontWeight.w900,color: Colors.white ),
              ),
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                  radius: 70.0,
                  backgroundColor: result == questionLenght / 2
                      ? Colors.yellow
                      : result < questionLenght / 2
                          ? incorrect
                          : correct,
                  child: Text(
                    '$result/$questionLenght',
                    style: textStyle,
                  )),
              Card(
                color: Colors.transparent,
                child: Text(
                  result == questionLenght / 2
                      ? 'Yarı Yarıya'
                      : result < questionLenght / 2
                          ? 'Düşük Sonuç'
                          : 'Güzel',
                  style: const TextStyle(color: neutral),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              GestureDetector(
                onTap: onPressed,
                child: const Card(
                  color: Colors.transparent,
                  child: Text('Yeniden Başla',style: TextStyle(fontSize: 20,color: Colors.cyanAccent),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

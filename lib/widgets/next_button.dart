import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key}):super (key: key);
  

  

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width:  double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
              
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: const Text('Sıradaki Soru',
               textAlign:TextAlign.center,
               style: TextStyle(fontSize: 18.0,color: Colors.cyanAccent),
              ),             
          ),
        ),
      ),
    );
  }
}
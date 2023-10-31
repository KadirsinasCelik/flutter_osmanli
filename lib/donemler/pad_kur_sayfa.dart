import 'package:flutter/material.dart';

class PadKurSayfa extends StatelessWidget {
  const PadKurSayfa({super.key, required this.infoText, required this.photo});
  final String infoText;
  final Image photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text('Osmanlı Padişahları',
            style: TextStyle(color: Colors.cyanAccent,fontStyle: FontStyle.italic)),
        backgroundColor: Colors.black38,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

        const Padding(padding: EdgeInsets.only(top: 10)),
        Card(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(color: Colors.red,
              child: SizedBox(
                height: 300,
                child: photo),
            ),
          ),
        ),
           const Padding(padding: EdgeInsets.only(top: 10)),
       Container(height: 10,color: Colors.amber,),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: Container(
                
                alignment: Alignment.center,
                child: Text(infoText,style: const TextStyle(color: Colors.white),))),
            ),
          ),
        ),
         Container(height: 10,color: Colors.amber,),
      ]),
    );
  }
}

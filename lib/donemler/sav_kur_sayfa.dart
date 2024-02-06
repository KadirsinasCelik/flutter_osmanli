import 'package:flutter/material.dart';

class SavKurSayfa extends StatefulWidget {
  const SavKurSayfa({super.key, required this.infoText, required this.photo});
  final String infoText;
  final Image photo;

  @override
  State<SavKurSayfa> createState() => _SavKurSayfaState();
}

class _SavKurSayfaState extends State<SavKurSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: const Text(
          'Osmanlı Dönem Savaşları',
          style: TextStyle(color: Colors.yellowAccent),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Card(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Card(
                    color: Colors.yellow,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150,
                        child: widget.photo,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 10,
                  color: Colors.amber,
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Card(
                  color: Colors.yellow[700],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(widget.infoText),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5)),
                Container(
                  height: 10,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
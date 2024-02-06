import 'package:flutter/material.dart';

class SadKurSayfa extends StatefulWidget {
  const SadKurSayfa({super.key, required this.infoText, required this.photo});
  final String infoText;
  final Image photo;

  @override
  State<SadKurSayfa> createState() => _SadKurSayfaState();
}

class _SadKurSayfaState extends State<SadKurSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text(
          'Osmanlı Sadrazamları',
          style: TextStyle(
            color: Colors.greenAccent,
            fontStyle: FontStyle.italic,
          ),
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
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.greenAccent,
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
                Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.infoText,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
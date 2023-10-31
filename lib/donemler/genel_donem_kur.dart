import 'package:flutter/material.dart';

class GenelKDonemSayfa extends StatefulWidget {
  const GenelKDonemSayfa(
      {super.key, required this.infoText, required this.photo});
  final String infoText;
  final Image photo;

  @override
  State<GenelKDonemSayfa> createState() => _GenelKDonemSayfaState();
}

class _GenelKDonemSayfaState extends State<GenelKDonemSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('asdasd'),
      ),
      body: ListView(
      
        children: [
            
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [const Padding(padding: EdgeInsets.only(top:10)),
                Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                  
                  child: Card
                  (color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150,
                        child: widget.photo),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                 Card(
                  color: Colors.red,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Center(child: Text(widget.infoText)),
                   ),
                 ),
              ],
            ),
          ),
        
         
        ],
      ),
    );
  }
}

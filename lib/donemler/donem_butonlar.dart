import 'package:flutter/material.dart';
import 'package:flutter_osmanli/categories/donemler_kategoriler.dart';

import '../pages/loading.dart';
import '../storage/database.dart';

class DonemButonlar extends StatelessWidget {
  const DonemButonlar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.blueGrey[600],
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Osmanlı  Dönemleri",
              style: TextStyle(
                  fontFamily: 'Sacramento',
                  color: Colors.cyanAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
          ),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: FutureBuilder(
          future: databaseGetAllPeriods(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    int now = index + 1;
                    return SizedBox(
                      height: 150,
                      child: Card(
                       shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(200.0) ) ,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(      
                              style: ElevatedButton.styleFrom(
                                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)) ,
                                  backgroundColor: Colors.cyan,
                                  ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DonemlerKategoriler(
                                        periodName: data['$now']['name'],
                                        oldPeriod: now,
                                      ),
                                    ));
                              },
                              child: Text(
                                  data['$now']['name'] +
                                      " " +
                                      "(${data['$now']['date']['start']} - ${data['$now']['date']['end']})",
                                  style: const TextStyle(color: Colors.amberAccent,fontStyle: FontStyle.italic,
                                       fontSize: 18,)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const LoadingPage();
            }
          },
        ));
  }
}

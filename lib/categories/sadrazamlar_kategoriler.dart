import 'package:flutter/material.dart';
import 'package:flutter_osmanli/storage/database.dart';
import 'package:flutter_osmanli/widgets/sayfa_yok.dart';

import '../donemler/sad_kur_sayfa.dart';
import '../pages/loading.dart';

class SadrazamKategoriler extends StatelessWidget {
  const SadrazamKategoriler(
      {super.key, required this.padisahPeriod, required this.padisahDonemadi});
  final int padisahPeriod;
  final String padisahDonemadi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text("$padisahDonemadi Sadrazamları",style: const TextStyle(color:Colors.greenAccent,fontStyle: FontStyle.italic ),),
      ),
      body: FutureBuilder(
        future: databaseGetAllSadrazamWithPeriod(padisahPeriod),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            //print("Gelen data: " + data.toString());
            if (data.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    int now = index + 1;
                    var img = Image.asset('assets/not_found.jpg');

                    if (data['$now']['image'] != null) {
                      img = Image.network(data['$now']['image']);
                    }

                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            color: Colors.black,
                            child: Center(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SadKurSayfa(
                                              infoText: data['$now']['info'],
                                              photo: img),
                                        ));
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      SizedBox(height: 90, child: img),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                             const SizedBox(height: 10,),
                                      Text(data['$now']['name'] +
                                          " (${data['$now']['active_years']['start']} - ${data['$now']['active_years']['end']})"),
                                            const SizedBox(height: 10,),
                                    ],
                                  )),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
              return const SayfaBulunamadi();
            }
          } else if (snapshot.hasError) {
            return const LoadingPage();
          } else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}

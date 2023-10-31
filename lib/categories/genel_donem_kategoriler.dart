import 'package:flutter/material.dart';
import 'package:flutter_osmanli/storage/database.dart';
import 'package:flutter_osmanli/widgets/sayfa_yok.dart';

import '../donemler/genel_donem_kur.dart';
import '../pages/loading.dart';

class GenelDonemKategoriler extends StatelessWidget {
  const GenelDonemKategoriler(
      {super.key, required this.padisahPeriod, required this.padisahDonemadi});
  final int padisahPeriod;
  final String padisahDonemadi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[200],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[700],
        title: Text("$padisahDonemadi Bilgisi"),
      ),
      body: FutureBuilder(
        future: databaseGetAllEpochWithPeriod(padisahPeriod),
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
                          child: Card(
                            color: Colors.red,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GenelKDonemSayfa(
                                            infoText: data['$now']['info'],
                                            photo: img),
                                      ));
                                },
                                child: Row(
                                  children: [
                                    SizedBox(height: 90, child: img),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(data['$now']['name'] +
                                        " (${data['$now']['active_years']['start']} - ${data['$now']['active_years']['end']})"),
                                  ],
                                )),
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

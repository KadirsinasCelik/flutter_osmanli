import 'package:flutter/material.dart';
import 'package:flutter_osmanli/storage/database.dart';
import 'package:flutter_osmanli/widgets/sayfa_yok.dart';
import '../donemler/sav_kur_sayfa.dart';
import '../pages/loading.dart';

//  burayı düzenle
class SavasKategoriler extends StatelessWidget {
  const SavasKategoriler(
      {super.key, required this.padisahPeriod, required this.padisahDonemadi});
  final int padisahPeriod;
  final String padisahDonemadi;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text("$padisahDonemadi Savaşları",style: const TextStyle(color: Colors.yellowAccent,fontStyle: FontStyle.italic),),
      ),
      body: FutureBuilder(
        future: databaseGetAllWarWithPeriod(padisahPeriod),
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
                        Card
                        (color: Colors.amber,
                          child: Card(
                            color: Colors.white70,
                            child: Card(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SavKurSayfa(
                                              infoText: data['$now']['info'],
                                              photo: img),
                                        ));
                                  },
                                  child: Column(
                                    
                                    children: [
                                      SizedBox(height: 125, child: img),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(data['$now']['name'] +
                                          " (${data['$now']['active_years']['start']} - ${data['$now']['active_years']['end']})"),
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

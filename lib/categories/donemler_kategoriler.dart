import 'package:flutter/material.dart';
import 'package:flutter_osmanli/categories/genel_donem_kategoriler.dart';
import 'package:flutter_osmanli/categories/sadrazamlar_kategoriler.dart';
import 'package:flutter_osmanli/categories/savas_kategoriler.dart';
import 'package:flutter_osmanli/pages/loading.dart';
import 'package:flutter_osmanli/storage/database.dart';
import 'package:flutter_osmanli/categories/padisahkategoriler.dart';

class DonemlerKategoriler extends StatelessWidget {
  const DonemlerKategoriler({
    super.key,
    required this.oldPeriod,
    required this.periodName,
  });
  final int oldPeriod;
  final String periodName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.west),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.blueGrey[700],
        title: Text(periodName,
            style: TextStyle(
              color: Colors.green[200],
              fontFamily: 'Sacramento',
              fontWeight: FontWeight.w900,
              fontSize: 38,
            )),
      ),
      body: FutureBuilder(
        future: databaseGetAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  int now = index + 1;

                  return SizedBox(
                    height: 100,
                    child: Card(
                      color: Colors.cyan[400],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(600),
                              topLeft: Radius.circular(600))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan[800],
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(600),
                                        topLeft: Radius.circular(600)))),
                            onPressed: () {
                         //     print("Oldperiod:$oldPeriod");

                              if (now == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PadisahKategoriler(
                                          padisahPeriod: oldPeriod,
                                          padisahDonemadi: periodName),
                                    ));
                              }

                              if (now == 2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SadrazamKategoriler(
                                          padisahPeriod: oldPeriod,
                                          padisahDonemadi: periodName),
                                    ));
                              }

                              if (now == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SavasKategoriler(
                                          padisahPeriod: oldPeriod,
                                          padisahDonemadi: periodName),
                                    ));
                              }

                              if (now == 4) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GenelDonemKategoriler(
                                          padisahPeriod: oldPeriod,
                                          padisahDonemadi: periodName),
                                    ));
                              }
                            },
                            child: Text(
                              data['$now'],
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Sacramento',
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue[100]),
                            )),
                      ),
                    ),
                  );
                },
              ),
            );
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

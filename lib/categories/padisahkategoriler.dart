import 'package:flutter/material.dart';
import 'package:flutter_osmanli/storage/database.dart';
import 'package:flutter_osmanli/widgets/sayfa_yok.dart';

import '../donemler/pad_kur_sayfa.dart';
import '../pages/loading.dart';

class PadisahKategoriler extends StatelessWidget {
  const PadisahKategoriler({super.key, required this.padisahPeriod, required this.padisahDonemadi});
  final int padisahPeriod;
  final String padisahDonemadi;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

       appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text("$padisahDonemadi Padişahları",style: const TextStyle(color: Colors.cyanAccent,fontStyle:FontStyle.italic),),
      ),
backgroundColor: Colors.cyan[500],
     

      body: FutureBuilder(future: databaseGetAllPadisahWithPeriod(padisahPeriod)
      ,builder: (context, snapshot) {
        if (snapshot.hasData){

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

                    if(data['$now']['image'] != null) {
                        img = Image.network(data['$now']['image']);
                    }
                    
                    
                    return Column(

                        children: [
                          Card(
                          
                            child: Card(
                          color: Colors.black12,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)) ,
                                    backgroundColor: Colors.black87),
                                    
                                
                                onPressed: 
                              () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => PadKurSayfa(infoText: data['$now']['info'], photo: img) ,));
                              },child: Row(
                                
                                
                                                      
                                                      
                                children: [SizedBox(
                                  height: 90,
                                  child: img),
                                  const SizedBox(width: 10,),
                                                      
                                  Text(data['$now']['name'] + " (${data['$now']['throne_time']['start']} - ${data['$now']['throne_time']['end']})"),
                                ],
                              )),
                            ),
                          )
                        ],
                    );
                  
                },),
              );
            }else {
              return const SayfaBulunamadi();
            }


        }else if (snapshot.hasError) {
          return const LoadingPage();
        }
        
        else {
          return const LoadingPage();
        }
      },
      ),
      

    );
  }
}
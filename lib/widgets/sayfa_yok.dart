import 'package:flutter/material.dart';

class SayfaBulunamadi extends StatelessWidget {
  const SayfaBulunamadi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: Colors.blueGrey,

body: Center(
  child:   Column(
  
    children: [

Icon(Icons.group,size: 15,color: Colors.blueGrey[800]),
      Icon(Icons.group,color: Colors.blueGrey[900],),
      Icon(Icons.group,size: 15,color: Colors.blueGrey[800],),
      const SizedBox(width: 10),
      const Text(textAlign: TextAlign.end,"Aradığınız Sayfa Bulunamadı",style: TextStyle(color:Colors.black,fontSize: 21,fontWeight: FontWeight.w900,fontFamily: 'Sacramento' ),),
      const SizedBox(width: 10),
      Icon(Icons.group,size: 15,color:Colors.blueGrey[800],),
      Icon(Icons.group,color: Colors.blueGrey[900]),
      Icon(Icons.group,size: 15,color: Colors.blueGrey[800],),

      const Expanded(flex:1,child: SizedBox()),
  
      const Expanded(flex:20,child: 
        
       Text(textAlign: TextAlign.center,"SAYIN KULLANICI GİRİŞ YAPTIĞINIZ SAYFA DÜZENLENMEKTEDİR. LÜTFEN DAHA SONRA TEKRAR ZİYARET EDİNİZ ",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),)),
    ],
  
  
),




    ));
  }
}
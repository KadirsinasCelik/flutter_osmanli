import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.cyan,
body: Center(
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      const CircularProgressIndicator(color: Colors.white30),
      const SizedBox(height: 10,),
      const Text("BEKLEME YERİ",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 20),),
      const SizedBox(height: 10,),
  Container(height: 10,color: Colors.amber,),
const SizedBox(height: 10,),
  const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.search,color: Colors.amberAccent,),
      Icon(Icons.person,color: Colors.orangeAccent),
      Icon(Icons.search,color: Colors.amberAccent,),
    ],
  ),
  const Text("Lütfen Bekleyin", style: TextStyle(fontFamily:"Sacramento",fontWeight: FontWeight.w900,fontSize: 30,color: Colors.black45 ),),
  const Text("Veri İşlemleriniz İçin",style: TextStyle(fontFamily:"Sacramento",fontWeight: FontWeight.w900,fontSize: 30,color: Colors.black45),),
  Container(height: 10,color: Colors.amber,),


]),
),


    );
  }
}
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnaSayfa createState() => _AnaSayfa();
}

class _AnaSayfa extends State<AnaSayfa> {
  final List<String> images = [
    "assets/1.Osman(I).jpg",
    "assets/2.Orhan.jpg",
    "assets/3.Murat(I).jpg",
    "assets/4.Bayezit(I).jpeg",
    "assets/5.Mehmet(I).jpg",
    "assets/6.Murat(II).jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Ana Sayfa",
            style:
                TextStyle(color: Colors.cyanAccent, fontFamily: "Sacramento",fontSize: 30,fontWeight:FontWeight.w900 ),
          ),
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.5,
              ),
              items: images
                  .map((item) => Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.fill,
                          height: 800,
                          width: 600,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.amber,
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    """Osmanlı Ansiklopedisi Uygulaması, içerisinde Osmanlı Devleti ile ilgili kategoriler içeren ve de bu kategorilerle alakalı mini testlerin bulunduğu öğretici ve bilgilendirici bir uygulamadır. Kategoriler içerisinde; padişahlar, önemli devlet adamları(sadrazam ve vezirler gibi) ,önemli savaşlar, özetlenmiş kısa tarih gibi kategorileriler bulunmaktadır.""",                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.cyan),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.amber,
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/alarm_manager.dart';
import 'package:flutter_osmanli/controller/authController.dart';
import 'package:flutter_osmanli/donemler/donem_butonlar.dart';
import 'package:flutter_osmanli/hive_page.dart';
import 'package:flutter_osmanli/homepage/home_page.dart';
import 'package:flutter_osmanli/pages/profile.dart';
import 'package:flutter_osmanli/pages/signIn.dart';
import 'package:flutter_osmanli/pages/soru_kategori.dart';

import '../theme/theme.dart';

class TabbBar extends StatefulWidget {
  const TabbBar({Key? key}) : super(key: key);

  @override
  State<TabbBar> createState() => _TabbBarState();
}

class _TabbBarState extends State<TabbBar> {
  late FirebaseAuth auth;
  late AuthController authController;
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    authController = AuthController(auth);
  }

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(seconds: 1),
      length: 3,
      child: Scaffold(
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkTheme
              ? CustomTheme.darkTheme.primaryColor
              : CustomTheme.lightTheme.primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                if (auth.currentUser == null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SignIn(controller: authController)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Profile(auth: auth, controller: authController)));
                }
              },
              icon: const Icon(Icons.person),
              color: Colors.blueGrey[800],
            ),
          ],
          title: const Text('Osmanlı Ansiklopedisi'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? CustomTheme.darkTheme.primaryColor
                      : CustomTheme.lightTheme.primaryColor,
                ),
                child: const Center(
                  child: Text(
                    'Osmanlı Ansiklopesi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ExpansionTile(
                  title: const Row(
                    children: [
                      Icon(Icons.book),
                      Text("Yapılacaklar Listesi"),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(Icons.addchart),
                          Text('Not Defteri'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Note()));
                      },
                    ),
                  ]),
              ExpansionTile(
                title:  const Row(
                  children: [
                    Icon(Icons.light),
                    Text(" Uygulama Tema Ayarları"),
                  ],
                ),
                children: [
                  ListTile(
                  
                    title: Row(
                      children: [
                        IconButton(
                        onPressed: toggleTheme,
                        icon: Icon(isDarkTheme
                            ? Icons.brightness_4
                            : Icons.brightness_5)),
                        InkWell(onTap: toggleTheme,
                          child: const Text('Koyu tema / Normal tema ')),
                      ],
                    ),
                  ),
                  
                ],
              ),
<<<<<<< Updated upstream

               ExpansionTile(
                  title: const Row(
                    children: [
                      Icon(Icons.account_tree_rounded),
                      Text("Ders Çlışma Teknikleri"),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(Icons.lock_clock),
                          Text('Pomodoro'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Note()));
                      },
                    ),
                  ]),
          /*    ExpansionTile(title: const Text('Dönem Testleri'), children: [
                ListTile(
                
=======
        

 ExpansionTile(
>>>>>>> Stashed changes
                  title: const Row(
                    children: [
                      Icon(Icons.book),
                      Text("Çalışma Teknikleri"),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(Icons.addchart),
                          Text('Pomodoro Tekniği'),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AlarmManager()));
                      },
                    ),
                  ]),








            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isDarkTheme
              ? CustomTheme.darkTheme.primaryColor
              : CustomTheme.lightTheme.primaryColor,
          child: const TabBar(
            labelColor: Colors.cyanAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'Ana Sayfa',
                icon: Icon(
                  Icons.home,
                ),
              ),
              Tab(
                text: 'Kategoriler',
                icon: Icon(Icons.menu_book_outlined),
              ),
              Tab(
                text: 'Dönem Testleri',
                icon: Icon(Icons.insights),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            AnaSayfa(),
            DonemButonlar(),
            SoruKategorileri(),
          ],
        ),
      ),
    );
  }
}

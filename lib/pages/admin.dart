import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osmanli/controller/authController.dart';
import 'package:flutter_osmanli/pages/tabbar.dart';

class Admin extends StatefulWidget {
  Admin({super.key});
  final AuthController authController = AuthController(FirebaseAuth.instance);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController messageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabbBar()),
    );
  }

  String? getUid() {
    final user = _auth.currentUser;
    return user?.uid;
  }

  Future<void> addNotification(String message, String title) async {
    try {
      String? uid = getUid();

      if (uid != null) {
        CollectionReference notificationsCollection =
            _firestore.collection('notifications');

        DocumentReference notificationDocRef = notificationsCollection
            .doc(Timestamp.now().toDate().toIso8601String());

        await notificationDocRef.set({
          'timestamp': Timestamp.now().toDate().toIso8601String(),
          'message': message,
          'title': title,
          'userId': uid,
        });

        log('Bildirim başarıyla eklendi.');
      } else {
        log('Kullanıcı oturum açmamış.');
      }
    } catch (error) {
      log('Bildirim eklenirken bir hata oluştu: $error');
    }
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: label,
        ),
      ),
    );
  }

  Widget buildNotificationCard(String title, String message) {
    return Card(
      elevation: 5, // Gölge ekleme
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(message),
        onTap: () {
          addNotification(message, title);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.green,
                title: const Text("Admin Yönetici Sayfası"),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Genel Bildirim"),
                    Tab(text: "Ödevlendirme Bildirimi"),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: _handleLogout,
                  ),
                ],
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Bütün kullanıcılara göndermek istediğiniz bildirimin içeriğini giriniz !",
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      buildTextField(messageController, "Bildirim İçeriği"),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Bütün kullanıcılara göndermek istediğiniz bildirimin başlığını giriniz !",
                            ),
                          ),
                        ),
                      ),
                      buildTextField(titleController, "Bildirim Başlığı"),
                      ElevatedButton(
                        onPressed: () {
                          addNotification(
                            messageController.text.toString(),
                            titleController.text.toString(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(fontSize: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: const Text("Gönder"),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const Card(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Ödev İsteme Sistemi"),
                      )),
                      buildNotificationCard(
                        "Kuruluş Dönem Testi",
                        "Öğretmeniniz bu testi sizin için görevlendirdi, lütfen tamamlamadıysanız tamamlayınız !",
                      ),
                      buildNotificationCard(
                        "Yükseliş Dönemi Testi",
                        "Öğretmeniniz bu testi sizin için görevlendirdi, lütfen tamamlamadıysanız tamamlayınız !",
                      ),
                      buildNotificationCard(
                        "Duraklama Dönemi Testi",
                        "Öğretmeniniz bu testi sizin için görevlendirdi, lütfen tamamlamadıysanız tamamlayınız !",
                      ),
                      buildNotificationCard(
                        "Gerileme Dönemi Testi",
                        "Öğretmeniniz bu testi sizin için görevlendirdi, lütfen tamamlamadıysanız tamamlayınız !",
                      ),
                      buildNotificationCard(
                        "Dağılma Dönemi Testi",
                        "Öğretmeniniz bu testi sizin için görevlendirdi, lütfen tamamlamadıysanız tamamlayınız !",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

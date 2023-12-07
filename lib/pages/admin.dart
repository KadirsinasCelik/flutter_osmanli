import 'package:flutter/material.dart';
import 'package:flutter_osmanli/pages/tabbar.dart';
import 'package:flutter_osmanli/controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Admin extends StatefulWidget {
   Admin({Key? key}) : super(key: key);
     final AuthController authController = AuthController(FirebaseAuth.instance);



  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  void _handleLogout() {
 
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TabbBar()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Yönetici Sayfası"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Bölüm 1"),
            Tab(text: "Bölüm 2"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed:        
            _handleLogout,

          
          ),
        ],
      ),
      drawer: Drawer(
         
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Card(
                color: Colors.transparent,
                child: Center(child: Text('Admin Menüsü'))),
            ),
            ListTile(
              title: const Text('Öğe 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Öğe 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text("Sayfa konulacak")),
          Center(child: Text("Sayfa konulacak")),
        ],
      ),
    );
  }
}

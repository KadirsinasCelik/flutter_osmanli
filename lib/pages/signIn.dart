import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osmanli/pages/admin.dart';
import 'package:flutter_osmanli/pages/profile.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

import '../controller/authController.dart';
import '../notification/notification_handler.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.controller});

  final AuthController controller;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Kullanıcı Hesap İşlemleri",
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 27,
          fontFamily: "Sacramento",
          fontWeight: FontWeight.w900,
        ),
      ),
      backgroundColor: Colors.cyan[900],
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          buildCard(
            child: buildTextFormField(
              controller: emailController,
              labelText: "Mail",
              prefixIcon: Icons.email_sharp,
              hintText: "Mail adresinizi giriniz",
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          buildCard(
            child: buildTextFormField(
              controller: passwordController,
              labelText: "Şifre",
              prefixIcon: Icons.key_sharp,
              hintText: "Şifrenizi giriniz",
              obscureText: true,
            ),
          ),
          const SizedBox(height: 10),
          buildButtonsRow(),
        ],
      ),
    );
  }

  Card buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  TextFormField buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      maxLength: obscureText ? 15 : 30,
      style: const TextStyle(color: Colors.cyan),
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(40),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.white70),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.cyanAccent, fontSize: 15),
        fillColor: Colors.black38,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: controller,
    );
  }

  Row buildButtonsRow() {
    return Row(
      children: [
        Expanded(
          child: buildCard(
            child: buildElevatedButton(
              label: "Giriş Yap",
              onPressed: signIn,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: buildCard(
            child: buildElevatedButton(
              label: "Kayıt Ol",
              onPressed: signUp,
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton buildElevatedButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        backgroundColor: Colors.black54,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }

  void signIn() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar("hata");
    } else {
      widget.controller
          .SignIn(emailController.text.toString(),
              passwordController.text.toString())
          .then((value) {
        if (value.currentUser == null) {
          showSnackBar("Böyle bir kullanıcı bulunamadı !");
        } else {
          checkAdmin(value);
        }
      });
    }
  }

  void signUp() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar("hata");
    } else {
      widget.controller
          .SignUp(emailController.text.toString(),
              passwordController.text.toString())
          .then((value) {
        if (value.currentUser == null) {
          showSnackBar("Gerekli alanları doğru formatta doldurunuz");
        } else {
          navigateToProfile(value); //checkadmin
        }
      });
    }
  }

  void checkAdmin(FirebaseAuth value) {
    var firebaseAuth = value;
    FirebaseFirestore.instance.collection("admins").get().then((value) async {
      if (mounted) {
        if (value.docs.isNotEmpty) {
          for (int i = 0; i < value.docs.length; i++) {
            if (value.docs[i].exists) {
              var data = value.docs[i].data();
              if (firebaseAuth.currentUser != null &&
                  data.entries.first.value == firebaseAuth.currentUser!.uid) {
                if (mounted) {
                  NotificationHandler().stopListening();
                  await FirebaseMessaging.instance
                      .unsubscribeFromTopic('all')
                      .then((value) => navigateToAdmin());
                }
                return;
              } else {
                if (mounted) {
                  NotificationHandler().stopListening();
                  NotificationHandler().startListening();
                  await FirebaseMessaging.instance
                      .unsubscribeFromTopic("all")
                      .then((value) async => {
                            await FirebaseMessaging.instance
                                .subscribeToTopic('all')
                                .then((value) {
                              if (mounted) {
                                navigateToProfile(firebaseAuth);
                              }
                            })
                          });
                }
              }
            }
          }
        } else {
          if (mounted) {
            NotificationHandler().stopListening();
            NotificationHandler().startListening();
            await FirebaseMessaging.instance
                .unsubscribeFromTopic("all")
                .then((value) async => {
                      await FirebaseMessaging.instance
                          .subscribeToTopic('all')
                          .then((value) {
                        if (mounted) {
                          navigateToProfile(firebaseAuth);
                        }
                      })
                    });
          }
        }
      }
    });
  }

  void navigateToAdmin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Admin()),
      (route) => false,
    );
  }

  void navigateToProfile(FirebaseAuth firebaseAuth) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(
          auth: firebaseAuth,
          controller: widget.controller,
        ),
      ),
      (route) => false,
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

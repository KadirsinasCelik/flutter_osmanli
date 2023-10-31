import 'package:flutter/material.dart';
import 'package:flutter_osmanli/pages/profile.dart';
import 'package:flutter_osmanli/utilities/constants.dart';

import '../controller/authController.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.controller});
  final AuthController controller;
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          "Kullanıcı  Hesap  İşlemleri",
          style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 27,
              fontFamily: "Sacramento",
              fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.cyan[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 30,
                  style: const TextStyle(color: Colors.cyan),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon:
                          const Icon(Icons.email_sharp, color: Colors.white70),
                      hintText: "Mail adresinizi giriniz",
                      hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
                      labelText: "Mail",
                      labelStyle:
                          const TextStyle(color: Colors.cyanAccent, fontSize: 15),
                      fillColor: Colors.black38,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: emailController,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 15,
                  style: const TextStyle(color: Colors.cyan),
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: const Icon(Icons.key_sharp, color: Colors.white70),
                      labelText: "Şifre",
                      labelStyle:
                          const TextStyle(color: Colors.cyanAccent, fontSize: 15),
                      hintText: "Şifrenizi giriniz",
                      hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
                      fillColor: Colors.black38,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: passwordController,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              backgroundColor: Colors.black54),
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("hata")));
                            } else {
                              widget.controller
                                  .SignIn(emailController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value.currentUser == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Böyle bir kullanıcı bulunamadı !")));
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(
                                                auth: value,
                                                controller: widget.controller,
                                              )),
                                      (route) => false);
                                }
                              });
                            }
                          },
                          child: const Text("Giriş Yap")),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.black54),
                          onPressed: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("hata")));
                            } else {
                              widget.controller
                                  .SignUp(emailController.text.toString(),
                                      passwordController.text.toString())
                                  .then((value) {

                                    if (value.currentUser==null) { //hata için yazdım
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Gerekli alanları doğru formatta doldurunuz"))
                                      );
                                      
                                    }else {
                                      Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                              auth: value,
                                              controller: widget.controller,
                                            )),
                                    (route) => false);
                                    }
                              });
                            }
                          },
                          child: const Text("Kayıt ol")),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

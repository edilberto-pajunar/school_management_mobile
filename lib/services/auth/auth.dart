import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;

  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();

  static GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  static GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  static GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();

  Future<void> login() async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    debugPrint("${userCredential.credential}");
  }
}
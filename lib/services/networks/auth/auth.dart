import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/views/screens/instructor/home.dart';
import 'package:school_management/views/screens/student/home.dart';

class Auth extends ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final NavigationServices nav = NavigationServices();

  bool isLoading = false;

  /// [showHUD] will trigger to show the waiting widget
  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();

  static GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  static GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  static GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();

  String? author;

  void updateAuthor(String? value) {
    author = value;
    notifyListeners();
  }

  Future<UserCredential?> getUserCredential() async {
    showHUD(true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: "${email.text}@gmail.com",
        password: password.text,
      );

      showHUD(false);
      return userCredential;
    } catch (e) {
      showHUD(false);
      throw "Error: $e";
    }
  }

  UserCredential? user;

  void loginAccount(BuildContext context, String? value) async {
    user = await getUserCredential().then((value) {
      if (value != null) {
        if (author == "Instructor") {
          nav.pushScreen(context,
            screen: const InstructorHomeScreen(),
          );
        } else if (author == "Student") {
          nav.pushScreen(context,
            screen: const PersonalHomeScreen(),
          );
        }
      }
      return value;
    });
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    await auth.signOut().then((value) {
      nav.popAll(context);
    });
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/models/auth/user.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/views/screens/admin/home.dart';
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

  static TextEditingController controlNumber = TextEditingController();
  static TextEditingController password = TextEditingController();

  static GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  static GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
  static GlobalKey<FormFieldState> passwordKey = GlobalKey<FormFieldState>();

  String? author;

  /// [updateAuthor] will update whether
  /// the user is instructor, student or admin
  void updateAuthor(String? value) {
    author = value;
    notifyListeners();
  }

  UserModel? user;

  /// [loginAccount] will prompt the user to log in
  Future<UserCredential?> loginAccount(BuildContext context) async {
    showHUD(true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: "${controlNumber.text}@gmail.com",
        password: password.text,
      ).then((UserCredential value) {
        // Update the user model
        user = UserModel(
          controlNumber: controlNumber.text,
          type: author!,
          id: value.user!.uid,
        );

        if (author == "instructors") {
          nav.pushScreen(context,
            screen: const InstructorHomeScreen(),
          );
        } else if (author == "students") {
          nav.pushScreen(context,
            screen: const PersonalHomeScreen(),
          );
        } else {
          nav.pushScreen(context, screen: const AdminHomeScreen());
        }
        notifyListeners();
        return value;
      });

      showHUD(false);
      return userCredential;
    } catch (e) {
      showHUD(false);
      throw "Error: $e";
    }
  }

  /// [logOut] lets the user logout and clear the
  /// credentials
  Future<void> logout(BuildContext context) async {
    await auth.signOut().then((value) {
      nav.popAll(context);
      controlNumber.clear();
      password.clear();
    });
  }
}
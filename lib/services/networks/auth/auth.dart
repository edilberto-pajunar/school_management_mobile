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
  Future<UserCredential?> loginAccount(BuildContext context, List<String> uids) async {

    final ThemeData theme = Theme.of(context);
    showHUD(true);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: "${controlNumber.text}@gmail.com",
        password: password.text,
      ).then((UserCredential value) {

        if (uids.contains(value.user!.uid)) {
          // Update the user model
          user = UserModel(
            controlNumber: controlNumber.text,
            type: author!,
            id: value.user!.uid,
          );

          if (author == "instructor") {
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
        } else {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              content: Text("Wrong control number/password.",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.red,
                ),
              ),
            );
          });
        }
        return value;
      });

      showHUD(false);
      return userCredential;
    } catch (e) {
      showHUD(false);
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text("Wrong control number/password.",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
        );
      });
      throw "Error: $e";
    }
  }

  /// [logOut] lets the user logout and clear the
  /// credentials
  Future<void> logout(BuildContext context) async {
    await auth.signOut().then((value) {
      nav.popAll(context);
      clearForm();

    });
  }

  void clearForm() {
    controlNumber.clear();
    password.clear();
    notifyListeners();
  }

  Stream<List<String>>? authListStream;

  Stream<List<String>> getAuth() {
    return db.collection(author!)
        .snapshots()
        .map(_authFromSnapshots);
  }

  List<String> _authFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return doc.get("id") as String;
    }).toList();
  }

  void updateAuthListStream() {
    authListStream = getAuth();
    notifyListeners();
  }
}
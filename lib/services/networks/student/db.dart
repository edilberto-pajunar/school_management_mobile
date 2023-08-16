import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StudentDB extends ChangeNotifier {

  final FirebaseFirestore db = FirebaseFirestore.instance;

  String? yearLevel;

  /// [updateYearLevel] will update the year level
  /// if grade7, or grade 8 etc.
  void updateYearLevel(String? value) {
    yearLevel = value;
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>? studentsFuture;

  Future<QuerySnapshot<Map<String, dynamic>>> populateStudentsFuture() async {
    return await db.collection("student")
        .where("grade", isEqualTo: yearLevel!)
        .get();
  }

  void updateStudentsFuture() {
    studentsFuture = populateStudentsFuture();
    notifyListeners();
  }


  final List<String> subjectList = [
    "Filipino",
    "English",
    "Science"
  ];

  String? uid;

  void updateUid(String? value) {
    uid = value;
    notifyListeners();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? gradesFuture;

  Future<DocumentSnapshot<Map<String, dynamic>>> populateGradesFuture() async {
    return await db.collection("student").doc(uid).get();
  }

  void updateGradesFuture() {
    gradesFuture = populateGradesFuture();
    notifyListeners();
  }
}
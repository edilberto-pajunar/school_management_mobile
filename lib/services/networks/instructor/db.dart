import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management/models/instructor/instructor.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';

class InstructorDB extends ChangeNotifier {

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final NavigationServices nav = NavigationServices();

  String? grade;
  String? section;

  /// [instructorStream] list of instructor
  Stream<List<InstructorModel>>? instructorStream;

  Stream<List<InstructorModel>> getInstructorStream() {
    return db.collection("instructor")
        .snapshots()
        .map(_instructorFromSnapshots);
  }

  List<InstructorModel> _instructorFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return InstructorModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void updateInstructorStream() {
    instructorStream = getInstructorStream();
    notifyListeners();
  }

  /// [studentsStream] students of the instructor
  Stream<List<StudentModel>>? studentsStream;

  Stream<List<StudentModel>> getStudentsStream() {
    return db.collection("instructor")
      .doc(firebaseAuth.currentUser!.uid)
      .collection("students")
      .snapshots()
      .map(_studentFromSnapshots);
  }

  List<StudentModel> _studentFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return StudentModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void updateStudentsStream() {
    studentsStream = getStudentsStream();
    notifyListeners();
  }


  /// [studentsFilteredStream] students generally
  Stream<List<StudentModel>>? studentsFilteredStream;


  Stream<List<StudentModel>> getStudentsFilteredStream() {
    return db.collection("students")
      .where("grade", isEqualTo: grade)
      .where("section", isEqualTo: section)
      .snapshots()
      .map(_studentsFilteredFromSnapshots);
  }

  List<StudentModel> _studentsFilteredFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return StudentModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void updateStudentsFilteredStream() {
    studentsFilteredStream = getStudentsFilteredStream();
    notifyListeners();
  }

  
  Future<void> addStudentFuture(StudentModel studentModel, BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    await db.collection("instructor")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("students")
        .doc(studentModel.id)
        .set(studentModel.toJson()).whenComplete(() {
          Scaffold.of(context).showBottomSheet((context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: ColorTheme.primaryYellow,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: ColorTheme.primaryRed,
                    radius: 50,
                    child: const Icon(Icons.check,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text("Add successfully!",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            );
          });

          Future.delayed(const Duration(seconds: 1), () {
            nav.pop(context);
          });
    });
  }

  /// add students

  static GlobalKey<FormState> formKey = GlobalKey();


  static TextEditingController nameField = TextEditingController();
  static GlobalKey<FormFieldState> nameKey = GlobalKey();

  static TextEditingController gradeField = TextEditingController();
  static GlobalKey<FormFieldState> gradeKey = GlobalKey();

  static TextEditingController sectionField = TextEditingController();
  static GlobalKey<FormFieldState> sectionKey = GlobalKey();

  static TextEditingController lrnField = TextEditingController();
  static GlobalKey<FormFieldState> lrnKey = GlobalKey();
}
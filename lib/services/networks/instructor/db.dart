import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_management/models/instructor/instructor.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:uuid/uuid.dart';

class InstructorDB extends ChangeNotifier {

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final NavigationServices nav = NavigationServices();

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

  final List<SelectionOption> gradeList = const [
    SelectionOption(id: 0, label: "Grade 7"),
    SelectionOption(id: 1, label: "Grade 8"),
    SelectionOption(id: 2, label: "Grade 9"),
    SelectionOption(id: 3, label: "Grade 10"),
    SelectionOption(id: 4, label: "STEM"),
    SelectionOption(id: 5, label: "HUMMS"),
    SelectionOption(id: 6, label: "TVL"),
    SelectionOption(id: 7, label: "GAS"),
  ];

  SelectionOption? grade;

  void updateGrade(SelectionOption? value) {
    grade = value;
    notifyListeners();
  }


  /// [addStudentFuture] add the students under the instructor
  /// in the database
  Future<void> addStudentFuture(BuildContext context) async {
    final ThemeData theme = Theme.of(context);

    final uuid = const Uuid().v1();

    final StudentModel studentModel = StudentModel(
        name: nameField.text,
        grade: gradeField.text,
        id: uuid,
        section: sectionField.text,
    );

    showHUD(true); // show loading

    await db.collection("students")
      .doc(uuid)
      .set(studentModel.toJson());

    await db.collection("instructor")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("students")
        .doc(uuid)
        .set(studentModel.toJson()).whenComplete(() {
          Scaffold.of(context).showBottomSheet((context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: ColorTheme.primaryRed,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 1),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(Icons.check,
                      size: 40,
                      color: ColorTheme.primaryRed,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: Text("Add successfully!",
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          });

          Future.delayed(const Duration(seconds: 1), () {
            nav.pop(context);
            clearForm();
            nav.pop(context);
          });

          showHUD(false);
    });
  }
  
  Future<void> deleteStudent(String uid, BuildContext context) async {

    await db.collection("instructor")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("students")
        .doc(uid)
        .delete().whenComplete(() {
          updateStudentsStream();
          nav.pop(context);
          debugPrint("Deleted! $uid");
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

  bool get validateAddStudent {
    return nameField.text.isNotEmpty
        && grade != null
        && sectionField.text.isNotEmpty;
  }

  void clearForm() {
    nameField.clear();
    grade = null;
    sectionField.clear();
    notifyListeners();
  }
}
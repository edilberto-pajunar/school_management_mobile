import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/registration/application.dart';
import 'package:school_management/models/student/new_subject.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/models/student/subject.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/api/key.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';

class StudentDB extends ChangeNotifier {

  final NavigationServices nav = NavigationServices();
  
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// [studentStream] will get the info of the student
  Stream<List<StudentModel>>? listOfStudentsStream;

  Stream<List<StudentModel>> getListOfStudentsStream() {

    return db.collection("students")
        .snapshots()
        .map(_listOfStudentsFromSnapshots);
  }

  List<StudentModel> _listOfStudentsFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      final fullName = "${data["personalInfo"]["firstName"]} ${data["personalInfo"]["lastName"]}";
      final grade = "${data["schoolInfo"]["gradeToEnroll"]}";
      final id = "${data["id"]}";
      final controlNumber = data["controlNumber"];
      final lrn = "${data["personalInfo"]["lrn"]}";
      final password = data["password"];

      final student = StudentModel(
        name: fullName,
        grade: grade,
        id: id,
        section: "A",
        controlNumber: controlNumber,
        lrn: lrn,
        password: password,
      );

      return student;
    }).toList();
  }

  void updateListOfStudentsStream() {
    listOfStudentsStream = getListOfStudentsStream();
    notifyListeners();
  }

  /// [studentStream] will get the info home of the student
  Stream<StudentModel>? studentStream;
  
  Stream<StudentModel> getUserInfo(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    return db.collection(auth.author!)
      .doc(firebaseAuth.currentUser!.uid)
      .snapshots().map(_studentFromSnapshots);
  }

  StudentModel _studentFromSnapshots(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    final fullName = "${data["personalInfo"]["firstName"]} ${data["personalInfo"]["lastName"]}";
    final grade = "${data["schoolInfo"]["gradeToEnroll"]}";
    final id = firebaseAuth.currentUser!.uid;
    final String? strand = "${data["schoolInfo"]["strand"]}";
    final controlNumber = data["controlNumber"];
    final lrn = "${data["personalInfo"]["lrn"]}";

    final student = StudentModel(
        name: fullName,
        grade: grade,
        id: id,
        section: strand ?? "A",
        controlNumber: controlNumber,
        lrn: lrn,
    );
    return student;
  }

  void updateStudentModel(BuildContext context) {
    studentStream = getUserInfo(context);
    notifyListeners();
  }

  /// [studentStream] will get the profile of the student
  Stream<ApplicationInfo>? studentProfileStream;

  Stream<ApplicationInfo> getUserProfile(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    return db.collection(auth.author!)
        .doc(firebaseAuth.currentUser!.uid)
        .snapshots().map(_studentProfileFromSnapshots);
  }

  ApplicationInfo _studentProfileFromSnapshots(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return ApplicationInfo.fromJson(data);
  }

  void updateStudentProfileStream(BuildContext context) {
    studentProfileStream = getUserProfile(context);
    notifyListeners();
  }

  bool hidePersonal = false;

  void updateHidePersonal() {
    hidePersonal = !hidePersonal;
    notifyListeners();
  }

  bool hideContact = false;

  void updateHideContact() {
    hideContact = !hideContact;
    notifyListeners();
  }

  bool canEdit = false;

  void updateCanEdit() {
    canEdit = !canEdit;
    notifyListeners();
  }


  /// [subjectStream] will generate the subjects of
  /// the student current log in
  Stream<List<Subject>>? subjectStream;

  Stream<List<Subject>> getSubject(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    final subjectStream = db.collection(auth.author!)
        .doc(firebaseAuth.currentUser!.uid)
        .collection("subjects")
        .snapshots()
        .map(_subjectFromSnapshots);
    return subjectStream;
  }

  List<Subject> _subjectFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((QueryDocumentSnapshot doc) {
      return Subject.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  void updateSubjectStream(BuildContext context) {
    subjectStream = getSubject(context);
    notifyListeners();
  }

  Future<void> updateSubjectEnrollment(BuildContext context, String uid) async {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    await db.collection(auth.author!)
      .doc(firebaseAuth.currentUser!.uid)
      .collection("subjects")
      .doc(uid)
      .update({
        "enrolled": true,
      }).then((value) {
        showDialog(context: context, builder: (context) {
          return const AlertDialog(
            content: Text("Congrats! You are enrolled."),
          );
        });
    });
  }



  SubjectModel get stemGrades {
    Map<String, dynamic> practicalResearch1 = {
      "title": "Practical Research 1",
      "grade": 100,
      "id": "1232131",
      "semester": 1,
      "strand": "stem",
      "year": "11",
      "instructor": {
        "name": "erwin",
        "id": "1232132"
      }
    };

    return SubjectModel.fromJson(practicalResearch1);
  }

  Future<void> uploadGrades() async {

    await db.collection("students")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("subjects")
        .add(stemGrades.toJson()).then((value) {
          print("Generated subjects!");
    });
  }

  Future<void> deleteStudent(BuildContext context, {
    required String id,
    required GlobalKey key,
  }) async {

    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Text("Are you sure you want to delete?"),
        actions: [
          TextButton(
            onPressed: () async {
              debugPrint("Deleting Student: $id");
              await db.collection("students")
                  .doc(id)
                  .delete();
              nav.pop(context);
            },
            child: const Text("Yes"),
          ),
          PrimaryButton(
            onPressed: () {
              nav.pop(context);
            },
            label: "No",
          ),
        ],
      );
    });


  }


  Future<Map<String, dynamic>> createPayment() async {
    try {
      Map<String, dynamic> body = {
        "amount": "1000",
        "currency": "USD",
      };

      http.Response response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          "Authorization": "Bearer ${ApiKey.stripeSecretKey}",
          "Content-Type": "application/x-www-form-urlencoded"
        }
      ).then((http.Response response) {

        if (response.body.isNotEmpty && response.statusCode == 200) {
          debugPrint(response.body);
          return response;

        } else {
          return response;
        }

      });


      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
    } catch (e) {
      print("Failed");
    }
  }

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPayment();

      const gPay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );

      notifyListeners();

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!["client_secret"] as String,
          style: ThemeMode.dark,
          merchantDisplayName: "Choi",
          googlePay: gPay,
        )).then((value) {
          displayPaymentSheet();
      });

    } catch (e) {
      throw "Error: ${e}";
    }
  }

  String? filePath;
  String? fileName;

  Future<void> pickFile(BuildContext context) async {
    await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["jpeg", "png","jpg"],
    ).then((value) {
      if (value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No File Selected."),
          ),
        );
      } else {
        filePath = value.files.single.path;
        fileName = value.files.single.name;
        notifyListeners();
      }
    });
  }


  Future<void> uploadFileFirebase() async {
    File file = File(filePath!);

    try {
    await storage.ref("test/$fileName")
        .putFile(file)
        .whenComplete(() {
          debugPrint("Uploaded Succesfully");
    });
  } catch (e) {
    throw "Error: ${e}";
    }
  }


}
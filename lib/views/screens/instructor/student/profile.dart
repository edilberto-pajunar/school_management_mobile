import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/views/widgets/body/future_wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB db = Provider.of<StudentDB>(context, listen: false);
      db.updateGradesFuture();
    });
  }

  @override
  Widget build(BuildContext context) {
    final StudentDB db = Provider.of<StudentDB>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureWrapper<DocumentSnapshot<Map<String, dynamic>>>(
        future: db.gradesFuture,
        child: (profile) {
          final StudentModel studentModel = StudentModel.fromJson(profile!.data()!);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(studentModel.name),
                  Text(studentModel.lrn),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/screens/instructor/student/grades.dart';
import 'package:school_management/views/widgets/body/future_wrapper.dart';

class ViewStudentsScreen extends StatefulWidget {
  const ViewStudentsScreen({super.key});

  @override
  State<ViewStudentsScreen> createState() => _ViewStudentsScreenState();
}

class _ViewStudentsScreenState extends State<ViewStudentsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB db = Provider.of<StudentDB>(context, listen: false);
      db.updateStudentsFuture();
    });
  }

  @override
  Widget build(BuildContext context) {

    final StudentDB db = Provider.of<StudentDB>(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.primaryRed,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: FutureWrapper<QuerySnapshot<Map<String, dynamic>>>(
        future: db.studentsFuture,
        child: (students) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.builder(
              itemCount: students!.docs.length,
              itemBuilder: (context, index) {
                final student = students.docs[index].data();

                final StudentModel studentModel = StudentModel.fromJson(student);

                return InkWell(
                  onTap: () {
                    db.updateUid(studentModel.id);
                    nav.pushScreen(context, screen: const GradesScreen());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.black,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(studentModel.name),
                        const Icon(Icons.assignment),
                      ],
                    ),
                  ),
                );
            }),
          );
        }
      ),
    );
  }
}

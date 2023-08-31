import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/new_subject.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/buttons/secondary.dart';

class StudentEnrollmentScreen extends StatefulWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  State<StudentEnrollmentScreen> createState() => _StudentEnrollmentScreenState();
}

class _StudentEnrollmentScreenState extends State<StudentEnrollmentScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB db = Provider.of<StudentDB>(context, listen: false);
      db.updateSubjectStream(context);

    });
  }

  @override
  Widget build(BuildContext context) {

    final StudentDB db = Provider.of<StudentDB>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Enrollment"),
        ),
        body: StreamWrapper<List<Subject>>(
          stream: db.subjectStream,
          child: (subjects) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataTable(
                    dataRowMaxHeight: 80,
                    columns: const [
                      DataColumn(
                        label: Text("Subject"),
                      ),
                      DataColumn(
                        label: Text("Enrolled?"),
                      ),
                    ],
                    rows: subjects!.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(Text(e.name)),
                          DataCell(
                            SecondaryButton(
                              isEnabled: !e.enrolled,
                              onPressed: () {
                                db.updateSubjectEnrollment(context, e.id.toString());
                              },
                              label: e.enrolled
                                ? "Already enrolled"
                                : "Enroll",
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

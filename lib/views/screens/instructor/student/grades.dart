import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/views/screens/instructor/student/profile.dart';
import 'package:school_management/views/widgets/body/future_wrapper.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {

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
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => nav.pushScreen(context, screen: const ProfileScreen()),
            child: Text("Profile",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: FutureWrapper<DocumentSnapshot<Map<String, dynamic>>>(
        future: db.gradesFuture,
        child: (grades) {
          final Grades gradeModel = Grades.fromJson(grades!.data()!["grades"]);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Grades"),
                DataTable(
                  columnSpacing: 30,
                  columns: [
                    DataColumn(
                      label: Text("Subject",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    DataColumn(
                      label: Text("1st",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    DataColumn(
                      label: Text("2nd",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    DataColumn(
                      label: Text("3rd",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    DataColumn(
                      label: Text("4th",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),

                  ],
                  rows: [
                    DataRow(
                      cells: [
                        const DataCell(Text("Mapeh")),
                        ...gradeModel.mapeh.map((int value) {
                          return DataCell(Text(value.toString()));
                        }).toList(),
                      ]
                    ),
                    DataRow(
                        cells: [
                          const DataCell(Text("Mathematics")),
                          ...gradeModel.mathematics.map((int value) {
                            return DataCell(Text(value.toString()));
                          }).toList(),
                        ]
                    ),

                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

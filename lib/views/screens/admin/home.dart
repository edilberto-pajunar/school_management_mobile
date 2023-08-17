import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/instructor/instructor.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/drawer/admin.dart';
import 'package:school_management/views/widgets/tiles/grey.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB studentDB = Provider.of<StudentDB>(context, listen: false);
      final InstructorDB instructorDB = Provider.of<InstructorDB>(context, listen: false);
      studentDB.updateListOfStudentsStream();
      instructorDB.updateInstructorStream();
    });
  }

  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);
    final ThemeData theme = Theme.of(context);
    final StudentDB studentDB = Provider.of<StudentDB>(context);
    final InstructorDB instructorDB = Provider.of<InstructorDB>(context);

    final String date = DateFormat("MMMM-dd-yyyy").format(DateTime.now());


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => auth.logout(context),
              style: TextButton.styleFrom(
              ),
              child: Text("Logout",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        drawer: const AdminDrawer(),
        body: StreamWrapper<List<InstructorModel>>(
          stream: instructorDB.instructorStream,
          child: (instructors) {
            return StreamWrapper<List<StudentModel>>(
              stream: studentDB.listOfStudentsStream,
              child: (students) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Welcome, Admin",
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: 12.0),
                      GreyTile(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Dashboard",
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text("As of $date:",
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GreyTile(
                              backgroundColor: Colors.black,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("${students!.length}",
                                    style: theme.textTheme.titleMedium!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text("Total Students",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 50.0),
                                  LinearPercentIndicator(
                                    percent: students.length / 100,
                                    barRadius: const Radius.circular(12),
                                    lineHeight: 12,
                                    backgroundColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: GreyTile(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: const Offset(0, 4),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                )
                              ],
                              backgroundColor: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text("${instructors!.length}",
                                    style: theme.textTheme.titleMedium!.copyWith(
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text("Total Instructors",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                    ),
                                  ),
                                  const SizedBox(height: 50.0),
                                  LinearPercentIndicator(
                                    percent: instructors.length / 100,
                                    barRadius: const Radius.circular(12),
                                    lineHeight: 12,
                                    progressColor: ColorTheme.primaryRed,
                                    backgroundColor: ColorTheme.primaryBlack.withOpacity(0.1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),

                    ],
                  ),
                );
              }
            );
          }
        ),
      ),
    );
  }
}

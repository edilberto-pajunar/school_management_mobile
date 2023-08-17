import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/models/student/subject.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';

class PersonalGradesScreen extends StatefulWidget {
  const PersonalGradesScreen({super.key});

  @override
  State<PersonalGradesScreen> createState() => _PersonalGradesScreenState();
}

class _PersonalGradesScreenState extends State<PersonalGradesScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB db = Provider.of<StudentDB>(context, listen: false);
      db.updateSubjectStream(context);
      db.updateStudentModel(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final StudentDB db = Provider.of<StudentDB>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamWrapper<StudentModel>(
          stream: db.studentStream,
          child: (student) {
            return StreamWrapper<List<SubjectModel>>(
              stream: db.subjectStream,
              child: (subjects) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Grades",
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 24.0),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2.0,
                              ),
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("${student!.name}, [${student.lrn}]",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2.0,
                                    ),
                                  ]
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: ColorTheme.primaryRed,
                                    ),
                                    child: Text("School Year 2223 First Semester",
                                      style: theme.textTheme.bodyMedium!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text("Admission Status",
                                          style: theme.textTheme.bodyLarge!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text("Continuing"),
                                        const SizedBox(height: 12.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                        const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subjects",
                              style: theme.textTheme.titleSmall,
                            ),
                            Text("Grades",
                              style: theme.textTheme.titleSmall,
                            )
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: subjects!.length,
                          itemBuilder: (context, index) {

                            final subject = subjects[index];

                            return  Container(
                              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Colors.grey : Colors.white,
                              ),
                              child: CustomListTile(
                                title: Text(subject.title,
                                  style: theme.textTheme.titleSmall,
                                ),
                                subtitle: Text("Unit No. ${subject.unit}"),
                                trailing: Text("${subject.grade ?? "N/A"}"),
                              ),
                            );
                          },
                        ),

                        // PrimaryButton(
                        //   onPressed: () => db.uploadGrades(),
                        //   label: "generate",
                        // ),
                      ],
                    ),
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

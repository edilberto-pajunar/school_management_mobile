import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/new_subject.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/functions/show_dialog.dart';
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
      db.updateStudentModel(context);
      db.updateSubjectStream(context);
    });
  }

  final key = GlobalKey<State<Tooltip>>();

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final StudentDB db = Provider.of<StudentDB>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),
        body: StreamWrapper<StudentModel>(
          stream: db.studentStream,
          child: (student) {
            return StreamWrapper<List<Subject>>(
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
                                    child: Text("School Year ${DateTime.now().year} First Semester",
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
                        const SizedBox(height: 12.0),
                        Text("Click the subject to see overall grades",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 12.0),
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

                            double totalGrade = 0;
                            double average = 0;

                            for (var grade in subject.grades) {
                              totalGrade += grade!.grade!;

                              average = totalGrade / subject.grades.length;
                            }


                            return  InkWell(
                              onTap: () {
                                CustomShowDialog().showGradesDialog(context,
                                  index: index,
                                  subject: subject,

                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                                decoration: BoxDecoration(
                                  color: index % 2 == 0 ? Colors.grey : Colors.white,
                                ),
                                child: CustomListTile(
                                  title: Text(subject.name,
                                    style: theme.textTheme.titleSmall!.copyWith(
                                      color: index % 2 == 0 ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  subtitle: Text("Unit No. ${subject.units}",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: index % 2 == 0 ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  trailing: Text("$average",
                                    style: theme.textTheme.bodyLarge!.copyWith(
                                      color: index % 2 == 0 ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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

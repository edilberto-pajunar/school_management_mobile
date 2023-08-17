import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/screens/student/grades.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';
import 'package:school_management/views/widgets/cards/schedule.dart';
import 'package:school_management/views/widgets/drawer/primary.dart';

class PersonalHomeScreen extends StatefulWidget {
  const PersonalHomeScreen({super.key});

  @override
  State<PersonalHomeScreen> createState() => _PersonalHomeScreenState();
}

class _PersonalHomeScreenState extends State<PersonalHomeScreen> {



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB studentDB = Provider.of<StudentDB>(context, listen: false);
      studentDB.updateStudentModel(context);
      studentDB.updateSubjectStream(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final StudentDB studentDB = Provider.of<StudentDB>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: const PrimaryDrawer(),
        body: StreamWrapper<StudentModel>(
          stream: studentDB.studentStream,
          child: (student) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Home",
                            style: theme.textTheme.titleLarge,
                          ),
                          PrimaryButton(
                            onPressed: () => studentDB.makePayment(),
                            label: "Settle Payment",
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Container(
                        padding: const EdgeInsets.all(12.0),
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
                            Text("${student!.name}, [${student.lrn}]"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),

                bottomSheet(context, student),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context, StudentModel student) {

    final NavigationServices nav = NavigationServices();
    final ThemeData theme = Theme.of(context);
    final StudentDB studentDB = Provider.of<StudentDB>(context);

    return StreamWrapper(
      stream: studentDB.subjectStream,
      child: (subject) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorTheme.primaryRed,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24.0),
                  topLeft: Radius.circular(24.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomListTile(
                        leading: const CircleAvatar(
                          radius: 30,
                        ),
                        title: Text(student.name,
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text("${student.grade}-${student.section}",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),

                      Text("Current Schedule",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: subject!.length,
                        itemBuilder: (context, index) {
                          return ScheduleCard(
                              title: subject[index].title,
                              time: "4:30pm"
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      PrimaryButton(
                        backgroundColor: ColorTheme.primaryYellow,
                        onPressed: () => nav.pushScreen(context, screen: const PersonalGradesScreen()),
                        color: ColorTheme.primaryBlack,
                        label: "Check my grades",
                        icon: Icon(Icons.arrow_circle_right,
                          color: ColorTheme.primaryRed,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

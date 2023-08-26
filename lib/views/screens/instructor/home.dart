import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/instructor/add.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({super.key});

  @override
  State<InstructorHomeScreen> createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final InstructorDB db = Provider.of<InstructorDB>(context, listen: false);
      db.updateStudentsStream();
    });
  }

  @override
  Widget build(BuildContext context) {

    final InstructorDB db = Provider.of<InstructorDB>(context);
    final ThemeData theme = Theme.of(context);
    final Auth auth = Provider.of<Auth>(context);
    final NavigationServices nav = NavigationServices();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Students",
            style: theme.textTheme.titleSmall!.copyWith(
              color: Colors.white,
            ),
          ),
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
        floatingActionButton: StreamWrapper<List<StudentModel>>(
          stream: db.studentsStream,
          child: (students) {
            return FloatingActionButton(
              backgroundColor: ColorTheme.primaryRed,
              onPressed: () => nav.pushScreen(context,
                  screen: const AddStudentsScreen(
              )),
              child: const Icon(Icons.add),
            );
          }
        ),
        body: StreamWrapper<List<StudentModel>>(
          stream: db.studentsStream,
          child: (students) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: students!.length,
                      itemBuilder: (context, index) {
                        return  Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0,),
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: CustomListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset(PngImages.user,
                                color: ColorTheme.primaryRed,
                              ),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: ColorTheme.primaryRed,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      content: Text("Are you sure you want to remove this student?",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await db.deleteStudent(students[index].id, context);
                                          },
                                          child: Text("Yes",
                                            style: theme.textTheme.bodyLarge!.copyWith(
                                              color: ColorTheme.primaryRed,
                                            ),
                                          ),
                                        ),
                                        TextButton(onPressed: () {
                                          nav.pop(context);
                                        }, child: Text("No",
                                            style: theme.textTheme.bodyLarge!.copyWith(
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                },
                                icon: const Icon(Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(students[index].name,
                              style: theme.textTheme.titleSmall,
                            ),
                            subtitle: Text("Grade: ${students[index].grade} - ${students[index].section}",
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';

class AddStudentInstructorScreen extends StatefulWidget {
  const AddStudentInstructorScreen({super.key});

  @override
  State<AddStudentInstructorScreen> createState() => _AddStudentInstructorScreenState();
}

class _AddStudentInstructorScreenState extends State<AddStudentInstructorScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final InstructorDB db = Provider.of<InstructorDB>(context, listen: false);
      db.updateStudentsFilteredStream();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final InstructorDB db = Provider.of<InstructorDB>(context, listen: false);
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: StreamWrapper(
            stream: db.studentsFilteredStream,
            child: (student) {
              return ListView.builder(
                itemCount: student!.length,
                itemBuilder: (context, index) {
                   return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0,),
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: CustomListTile(
                      leading: CircleAvatar(
                        child: Text("$index"),
                      ),
                      title: Text(student[index].name,
                        style: theme.textTheme.titleSmall,
                      ),
                      subtitle: Text("Grade: ${student[index].grade} - ${student[index].section}",
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: ColorTheme.primaryRed,
                        child: IconButton(
                          onPressed: () => db.addStudentFuture(student[index], context),
                          icon: const Icon(Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

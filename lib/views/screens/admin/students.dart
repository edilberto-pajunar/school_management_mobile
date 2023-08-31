import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';

class AdminStudentsScreen extends StatefulWidget {
  const AdminStudentsScreen({super.key});

  @override
  State<AdminStudentsScreen> createState() => _AdminStudentsScreenState();
}

class _AdminStudentsScreenState extends State<AdminStudentsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB db = Provider.of<StudentDB>(context, listen: false);
      db.updateListOfStudentsStream();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool showPass = true;

  void toggleShowPass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {

    final StudentDB studentDB = Provider.of<StudentDB>(context);
    final ThemeData theme = Theme.of(context);



    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        body: ModalProgressHUD(
          inAsyncCall: studentDB.isLoading,
          child: StreamWrapper<List<StudentModel>>(
            stream: studentDB.listOfStudentsStream,
            child: (student) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataTable(
                      columnSpacing: 5,
                      headingTextStyle: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 50,
                            child: Text("User"),
                          ),
                        ),
                        DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text("Control Number",
                                softWrap: true,
                              ),
                            )
                        ),
                        DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Text("Password"),
                            ),
                        ),
                        DataColumn(
                            label: Icon(Icons.group_remove_rounded)
                        ),
                      ],
                      rows: student!.map((e) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 80,
                                child: Text(e.name),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                  width: 100,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text("${e.controlNumber}",
                                      style: theme.textTheme.bodyMedium!.copyWith(
                                        color: Colors.blue,
                                      ),
                                ),
                                  ),
                              ),
                            ),
                            DataCell(
                                GestureDetector(
                                  onTap: () => toggleShowPass(),
                                  child: Text(
                                    showPass
                                      ? e.password!.replaceAll(RegExp(r"."), "*")
                                      : e.password!,
                                  ),
                                )
                            ),
                            DataCell(
                              InkWell(
                                borderRadius: BorderRadius.circular(24.0),
                                onTap: () {
                                  studentDB.deleteStudent(context,
                                    id: e.id,
                                    key: scaffoldKey,
                                  );
                                },
                                child: const Icon(Icons.close),
                              ),
                            ),
                          ]
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

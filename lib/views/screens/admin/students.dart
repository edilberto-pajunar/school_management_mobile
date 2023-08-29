import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {

    final StudentDB studentDB = Provider.of<StudentDB>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: StreamWrapper<List<StudentModel>>(
          stream: studentDB.listOfStudentsStream,
          child: (student) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    columnSpacing: 5,
                    columns: const [
                      DataColumn(
                        label: Text("User")
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
                          label: Text("Password")
                      ),
                    ],
                    rows: student!.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(e.name)
                          ),
                          DataCell(
                              Text("${e.controlNumber}",)
                          ),
                          DataCell(
                              Text("${e.password}",)
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
    );
  }
}

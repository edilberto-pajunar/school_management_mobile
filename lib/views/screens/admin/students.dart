import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/student/student.dart';
import 'package:school_management/services/networks/instructor/db.dart';
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
      final InstructorDB db = Provider.of<InstructorDB>(context, listen: false);
      db.updateStudentsStream();
    });
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final InstructorDB db = Provider.of<InstructorDB>(context);


    return Scaffold(
      appBar: AppBar(),
      body: StreamWrapper<List<StudentModel>>(
        stream: db.studentsStream,
        child: (students) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Number of students in each grade",
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24.0),
              PieChart(
                animationDuration: const Duration(milliseconds: 800),
                chartRadius: MediaQuery.of(context).size.width * 0.5,
                chartLegendSpacing: 20,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.bottom,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                dataMap: {
                  "": 3,
                  "iron": 2,
                }
              ),
            ],
          );
        }
      ),
    );
  }
}

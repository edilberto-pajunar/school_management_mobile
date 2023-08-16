import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';
import 'package:school_management/views/widgets/drawer/primary.dart';

class PersonalGradesScreen extends StatelessWidget {
  const PersonalGradesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: const PrimaryDrawer(),
        body: SingleChildScrollView(
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
                admissionStatus(context),
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
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return  Container(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.grey : Colors.white,
                      ),
                      child: CustomListTile(
                        title: Text("Basic Calculus",
                          style: theme.textTheme.titleSmall,
                        ),
                        subtitle: const Text("Unit No. 1"),
                        trailing: const Text("100"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget admissionStatus(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
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
            child: Text("Choi Pajunar, (2019-03586-MN-0)",
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
                  child: Text("School Year 2223 Second Semester",
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
    );
  }
}

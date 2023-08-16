import 'package:flutter/material.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/screens/student/grades.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';
import 'package:school_management/views/widgets/cards/schedule.dart';
import 'package:school_management/views/widgets/drawer/primary.dart';

class PersonalHomeScreen extends StatelessWidget {
  const PersonalHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //     onPressed: (){},
          //     icon: const Icon(Icons.people),
          //   ),
          // ],
        ),
        drawer: const PrimaryDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Home",
                    style: theme.textTheme.titleLarge,
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Choi Pajunar, (2019-03586-MN-0)"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),

            bottomSheet(context),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    final NavigationServices nav = NavigationServices();
    final ThemeData theme = Theme.of(context);

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
                    title: Text("Edilberto Jr. S. Pajunar",
                      style: theme.textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text("BSCPE 4-5",
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const ScheduleCard(
                          title: "Differential Calculus",
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
}

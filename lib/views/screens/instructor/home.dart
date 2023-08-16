import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/instructor/student/view.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/cards/instructor_class.dart';

class InstructorHomeScreen extends StatelessWidget {
  const InstructorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();
    final StudentDB db = Provider.of<StudentDB>(context);
    final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset(PngImages.background),
            ),
            const SizedBox(width: 10,),
            Text("Welcome Instructor",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => auth.logout(context),
            child: Text("Logout",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InstructorClassCard(
              label: "Junior High School",
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                    context: context, builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.0),
                        bottom: Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Please choose a grade level:"),
                          PrimaryButton(
                            onPressed: () {
                              db.updateYearLevel("7");
                              nav.pop(context);
                              nav.pushScreen(context, screen: const ViewStudentsScreen());
                            },
                            label: "Grade 7",
                          ),
                          PrimaryButton(
                            onPressed: () {
                              db.updateYearLevel("8");
                              nav.pop(context);
                              nav.pushScreen(context, screen: const ViewStudentsScreen());
                            },
                            label: "Grade 8",
                          ),
                          PrimaryButton(
                            onPressed: () {
                              db.updateYearLevel("9");
                              nav.pop(context);

                            },
                            label: "Grade 9",
                          ),
                          PrimaryButton(
                            onPressed: () {
                              db.updateYearLevel("10");
                              nav.pop(context);
                            },
                            label: "Grade 10",
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
            InstructorClassCard(
              label: "S.T.E.M.",
              onTap: () {},
            ),
            InstructorClassCard(
              label: "H.U.M.M.S.",
              onTap: () {},
            ),
            InstructorClassCard(
              label: "G.A.S.",
              onTap: () {},
            ),
            InstructorClassCard(
              label: "T.V.L.",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/student/enrollment.dart';
import 'package:school_management/views/screens/student/grades.dart';
import 'package:school_management/views/screens/student/home.dart';
import 'package:school_management/views/screens/student/profile.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final NavigationServices nav = NavigationServices();
    final ThemeData theme = Theme.of(context);
    final Auth auth = Provider.of<Auth>(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(PngImages.background,
              height: 100,
              width: 100,
            ),
          ),
          ListTile(
            onTap: () {
              nav.pop(context);
              nav.pop(context);
              nav.pushScreen(context, screen: const PersonalHomeScreen());
            },
            title: const Text("Home"),
          ),
          ListTile(
            onTap: () {
              nav.pop(context);
              nav.pushScreen(context, screen: const StudentEnrollmentScreen());
            },
            title: const Text("Enrollment"),
          ),
          ListTile(
            onTap: () {
              nav.pop(context);
              nav.pushScreen(context, screen: const PersonalGradesScreen());
            },
            title: const Text("Grades"),
          ),
          ListTile(
            onTap: () {
              nav.pop(context);
              nav.pushScreen(context, screen: const PersonalProfileScreen());
            },
            title: const Text("Profile"),
          ),
          ListTile(
            onTap: () {
              auth.logout(context);
            },
            title: Text("Logout",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

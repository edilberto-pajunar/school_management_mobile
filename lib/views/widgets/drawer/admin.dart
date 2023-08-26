import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/admin/students.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);
    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();

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
              nav.pushScreen(context, screen: const AdminStudentsScreen());
            },
            title: const Text("Students"),
          ),
          ListTile(
            onTap: () {
              // nav.pop(context);
              // nav.pop(context);
              // nav.pushScreen(context, screen: const PersonalHomeScreen());
            },
            title: const Text("Instructors"),
          ),
          ListTile(
            onTap: () {
              // nav.pop(context);
              // nav.pop(context);
              // nav.pushScreen(context, screen: const PersonalHomeScreen());
            },
            title: const Text("About"),
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

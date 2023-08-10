import 'package:flutter/material.dart';
import 'package:school_management/services/functions/navigation.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/auth/login.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final NavigationServices nav = NavigationServices();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(PngImages.background,
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 100),
            const Text("Logged in as a"),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Instructor",
              onPressed: () => nav.pushScreen(context,
                screen: const LoginScreen(
                  author: "Instructor",
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Student",
              onPressed: () => nav.pushScreen(context,
                screen: const LoginScreen(
                  author: "Student",
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Admin",
              onPressed: () => nav.pushScreen(context,
                screen: const LoginScreen(
                  author: "Admin",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

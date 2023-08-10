import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/auth/auth.dart';
import 'package:school_management/services/functions/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/auth/login.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final NavigationServices nav = NavigationServices();
    final Auth auth = Provider.of<Auth>(context);

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
              onPressed: () {
                auth.updateAuthor("Instructor");
                nav.pushScreen(context,
                  screen: const LoginScreen(),
                );
              },
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Student",
              onPressed: () {
                auth.updateAuthor("Student");
                nav.pushScreen(context,
                  screen: const LoginScreen(),
                );
              },
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Admin",
              onPressed: () {
                auth.updateAuthor("Admin");
                nav.pushScreen(context,
                  screen: const LoginScreen(),
                );
              },
            ),
            const SizedBox(height: 24.0),
            const Align(
              alignment: Alignment.bottomRight,
              child: Text(
                  "Let us help you make your document."
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {},
                child: Text("Click here to start.",
                  style: TextStyle(
                    color: ColorTheme.primaryRed,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

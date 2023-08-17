import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/screens/applications/transferee.dart';
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
                auth.updateAuthor("instructor");
                nav.pushScreen(context,
                  screen: const LoginScreen(),
                );
              },
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Student",
              onPressed: () {
                auth.updateAuthor("students");
                nav.pushScreen(context,
                  screen: const LoginScreen(),
                );
              },
            ),
            const SizedBox(height: 12.0),
            PrimaryButton(
              label: "Admin",
              onPressed: () {
                auth.updateAuthor("admin");
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
                onTap: () => nav.pushScreen(context, screen: const TransfereeFormScreen()),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/auth/auth.dart';
import 'package:school_management/services/functions/navigation.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    this.author,
    super.key,
  });

  final String? author;

  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);
    final double height = MediaQuery.of(context).size.height;
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      body: Form(
        key: Auth.loginKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(PngImages.background,
                    height: 120,
                    width: 120,
                  ),
                  const SizedBox(height: 24.0),
                  Text("Log in as $author",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  PrimaryTextField(
                    fieldKey: Auth.emailKey,
                    label: "Email",
                    controller: Auth.email,
                    hintText: "Email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24.0),
                  PrimaryTextField(
                    fieldKey: Auth.passwordKey,
                    label: "Password",
                    controller: Auth.password,
                    hintText: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: height * 0.2),
                  PrimaryButton(
                    onPressed: () async {
                      if (Auth.loginKey.currentState!.validate()) {
                        await auth.login();
                      }
                    },
                    label: "Login",
                  ),
                  TextButton(
                    onPressed: () => nav.popScreen(context),
                    child: const Text("Return to main screen"),
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

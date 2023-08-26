import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/screens/forms/junior_high/incoming.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();
    final Application application = Provider.of<Application>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Choose your enrollment type:",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 48.0),
              PrimaryButton(
                onPressed: () {
                  application.updateFormLevel("7");
                  nav.pushScreen(context, screen: const IncomingJuniorFormScreen());
                },
                label: "For Incoming Grade 7",
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                onPressed: () {},
                label: "For Transferees in Junior High School",
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                onPressed: () {},
                label: "For Continouing Junior High School Learners",
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                onPressed: () {},
                label: "For New Senior High School Learners from SJAISS (Gr.11)",
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                onPressed: () {},
                label: "For New Senior High School Learners from Other Schools",
              ),
              const SizedBox(height: 24.0),
              PrimaryButton(
                onPressed: () {},
                label: "For Continouing Senior High School Learners",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

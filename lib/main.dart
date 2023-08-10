import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/values/theme.dart';
import 'package:school_management/views/screens/auth/home.dart';

import 'services/networks/auth/auth.dart';
import 'services/networks/registration/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Application()),
      ],
      child: MaterialApp(
        theme: CustomTheme.themeData,
        home: const HomeScreen(),
      ),
    );
  }
}

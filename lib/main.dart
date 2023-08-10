import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/auth/auth.dart';
import 'package:school_management/values/theme.dart';
import 'package:school_management/views/screens/auth/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        theme: CustomTheme.themeData,
        home: const HomeScreen(),
      ),
    );
  }
}

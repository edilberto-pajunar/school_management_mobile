import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:school_management/firebase_options.dart';
import 'package:school_management/models/student/profile.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/services/networks/storage.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/values/strings/api/key.dart';
import 'package:school_management/values/theme.dart';
import 'package:school_management/views/screens/auth/home.dart';
import 'services/networks/registration/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKey.stripePublishableKey;

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
        ChangeNotifierProvider(create: (context) => Application()),
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => Commons()),
        ChangeNotifierProvider(create: (context) => InstructorDB()),
        ChangeNotifierProvider(create: (context) => ProfileServices()),
        ChangeNotifierProvider(create: (context) => StorageProvider()),
        ChangeNotifierProvider(create: (context) => StudentDB()),
      ],
      child: MaterialApp(
        theme: CustomTheme.themeData,
        home: const HomeScreen(),
      ),
    );
  }
}

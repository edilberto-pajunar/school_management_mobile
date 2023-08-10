import 'package:flutter/material.dart';
import 'package:school_management/values/strings/images.dart';

class InstructorHomeScreen extends StatelessWidget {
  const InstructorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset(PngImages.background),
            ),
            const SizedBox(width: 10,),
            const Text("Welcome Instructor",),
          ],
        ),
        centerTitle: true,
      ),
    );
  }
}

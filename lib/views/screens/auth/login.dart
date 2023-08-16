import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/auth/auth.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/images.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/fields/password.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    final Auth auth = Provider.of<Auth>(context);
    final double height = MediaQuery.of(context).size.height;
    final NavigationServices nav = NavigationServices();


    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        child: Form(
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
                    Text("Log in as ${auth.author}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    PrimaryTextField(
                      fieldKey: Auth.emailKey,
                      label: "Control Number",
                      controller: Auth.email,
                      hintText: "Control Number",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 24.0),
                    PasswordTextField(
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
                          auth.loginAccount(context, auth.author);
                        }
                      },
                      label: "Login",
                    ),
                    TextButton(
                      onPressed: () => nav.pop(context),
                      child: const Text("Return to main screen"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

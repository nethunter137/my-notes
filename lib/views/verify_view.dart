import 'package:flutter/material.dart';
import 'package:mynotes2/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(children: [
        const Text("Please verify your email address:"),
        TextButton(
          onPressed: () async {
            final user = await AuthService.firebase().sendEmailVerification();
          },
          child: const Text("Send email verification"),
        ),
        TextButton(
            onPressed: () {
              AuthService.firebase().logOut();
            },
            child: const Text("restart"))
      ]),
    );
  }
}

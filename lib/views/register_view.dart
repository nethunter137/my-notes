import 'package:flutter/material.dart';
import 'package:mynotes2/services/auth/auth_exceptions.dart';
import 'package:mynotes2/services/auth/auth_service.dart';
import 'package:mynotes2/ultilities/dialogs/error_dialog.dart';

import 'dart:developer' as devtools show log;

import 'package:mynotes2/views/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Enter your email here",
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Enter your password here",
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
              } on WeakPasswordAuthException {
                await showErrorDialog(context, "weak password");
                devtools.log("weak password");
              } on EmailAlreadyInUsedAuthException {
                await showErrorDialog(context, "email already in used");
                devtools.log("email already in used");
              } on InvalidEmailAuthException {
                await showErrorDialog(context, "invalid email address");
                devtools.log("invalid email address");
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
                devtools.log("idk what happened");
              } catch (e) {
                await showErrorDialog(context, 'Error: ${e.toString}');
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text("Already a member? Login here"),
          )
        ],
      ),
    );
  }
}

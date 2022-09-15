import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes2/ultilities/show_error_dialogs.dart';
import 'dart:developer' as devtools show log;
import 'package:mynotes2/views/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Column(children: [
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter your email here',
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Enter your password here',
          ),
        ),
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                noteRoute,
                (route) => false,
              );
              devtools.log(userCredential.toString());
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                await showErrorDialog(context, "user not found");
                devtools.log('User not found');
              } else if (e.code == 'wrong-password') {
                await showErrorDialog(context, "wrong password");
                devtools.log('Wrong password');
              } else {
                await showErrorDialog(context, 'Error: ${e.code}');
              }
            } catch (e) {
              await showErrorDialog(context, 'Error: ${e.toString}');
            }
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
          child: const Text("Not registed? Register here"),
        )
      ]),
    );
  }
}

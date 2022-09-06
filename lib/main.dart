import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes2/firebase_options.dart';
import 'package:mynotes2/views/login.dart';
import 'package:mynotes2/views/login_view.dart';
import 'package:mynotes2/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Homepage(),
    routes: {
      "/login/": (context) => const LoginView(),
      "/register/": (context) => const RegisterView(),
    },
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // print(user);
            // if (user?.emailVerified ?? false) {
            //   return const Text("Done");
            // } else {
            //   return const VerifyEmailView();
            // }
            return const LoginView();
          default:
            return const Text("Loading...");
        }
      },
    );
  }
}

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
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send email verification"),
        )
      ]),
    );
  }
}
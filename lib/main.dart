import 'package:flutter/material.dart';
import 'package:mynotes2/services/auth/auth_service.dart';
import 'package:mynotes2/views/login_view.dart';
import 'package:mynotes2/views/notes/new_notes_view.dart';
import 'package:mynotes2/views/notes/notes_view.dart';
import 'package:mynotes2/views/register_view.dart';
import 'package:mynotes2/views/routes.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Homepage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      noteRoute: (context) => const NotesView(),
      newNoteRoute: (context) => const NewNoteView(),
    },
  ));
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            print(user);
            // CANT VERIFY SO YOU CANT USE THIS LOGIC
            // if (user != null) {
            //   if (user.emailVerified) {
            //     print('Email is verified');
            //   } else {
            //     return const VerifyEmailView();
            //   }
            // } else {
            //   return const LoginView();
            // }
            if (user != null) {
              return const NotesView();
            }
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

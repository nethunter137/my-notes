import 'package:flutter/material.dart';
import 'package:mynotes2/enums/menu_action.dart';
import 'package:mynotes2/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes2/views/routes.dart';

class Notesview extends StatefulWidget {
  const Notesview({Key? key}) : super(key: key);

  @override
  State<Notesview> createState() => _NotesviewState();
}

class _NotesviewState extends State<Notesview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            //devtools.log(value.toString());
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                devtools.log(shouldLogout.toString());
                if (shouldLogout) {
                  await AuthService.firebase().logOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Log out"),
              ),
            ];
          })
        ],
      ),
      body: const Text("Hello world"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Log1 out"),
            content: const Text("Are you sure you want to log out?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Log2 out"),
              ),
            ]);
      }).then(
    (value) => value ?? false,
  );
}

import 'package:flutter/material.dart';
import 'package:mynotes2/ultilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDiaglog<bool>(
    context: context,
    title: "Log Out",
    content: "Are you sure you want to log out?",
    optionsBuilder: () => {
      "Cancel": false,
      "Log Out": true,
    },
  ).then((value) => value ?? false);
}

import 'package:flutter/material.dart';
import 'package:mynotes2/ultilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDiaglog<bool>(
    context: context,
    title: "Delete",
    content: "Are you sure you want to delete this item?",
    optionsBuilder: () => {
      "Cancel": false,
      "Yes": true,
    },
  ).then((value) => value ?? false);
}

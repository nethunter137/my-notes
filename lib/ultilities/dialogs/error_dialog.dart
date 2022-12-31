import 'package:flutter/cupertino.dart';
import 'package:mynotes2/ultilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDiaglog(
      context: context,
      title: "An error occurred",
      content: text,
      optionsBuilder: () => {"OK": null});
}



import 'package:flutter/material.dart';
import '../common/const.dart';

showCustomAlertDialog(
    BuildContext context, {
      String? titleText,
      Widget? title,
      String? contentText,
      Widget? content,
      bool dismissible = true,
      List<Widget>? actions,
    }) async {
  return await showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        shape: RoundedRectangleBorder(
          borderRadius: Const.borderRadiusCircular,
        ),
        title: titleText == null ? null : title ?? Text(titleText),
        content: content ?? (contentText == null ? null : Text(contentText)),
        actions: actions,
      );
    },
  );
}
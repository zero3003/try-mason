import 'package:flutter/material.dart';

import 'color.dart';
import 'dimen_const.dart';

// BoxDecoration kBoxDecoration({Color? color, Color? borderColor}) {
//   return BoxDecoration(
//     border: Border.all(color: borderColor ?? Colors.white),
//     color: color ?? Colors.white,
//     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//   );
// }
//
// BoxDecoration kBoxDecorationError() {
//   return BoxDecoration(
//     color: const Color(0xffB42F32).withOpacity(0.5),
//     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//   );
// }
//
// RoundedRectangleBorder kRoundedRectangle({Color? color}) {
//   return RoundedRectangleBorder(
//       side: BorderSide(width: 1.0, color: color ?? const Color(0xFF000000)), borderRadius: BorderRadius.circular(10.0));
// }

Gradient? gradientColor() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colorPrimary,
      colorPrimary2,
    ],
  );
}

BoxDecoration infoBoxDecoration() {
  return BoxDecoration(
    gradient: gradientColor(),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(Dimens.defaultBoxBorder),
      topRight: Radius.circular(Dimens.defaultBoxBorder),
    ),
  );
}

BoxDecoration whiteBoxDecoration() {
  return const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(Dimens.defaultBoxBorder),
      bottomRight: Radius.circular(Dimens.defaultBoxBorder),
    ),
  );
}

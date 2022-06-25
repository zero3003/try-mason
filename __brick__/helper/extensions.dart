import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String toDMY() => DateFormat("yyyy-MM-dd").format(toLocal());

  String toDMYHM() => DateFormat("yyyy-MM-dd HH:mm").format(toLocal());

  String toYM() => DateFormat("yyyy-MM").format(toLocal());

  String toFormattedDate() {
    initializeDateFormatting();
    return DateFormat.yMMMMd('id').format(toLocal());
  }

  String toFormattedMonth() {
    initializeDateFormatting();
    return DateFormat.yMMMM('id').format(toLocal());
  }

  String toFormattedDateHour() {
    initializeDateFormatting();
    return '${DateFormat.yMMMMd('id').format(toLocal())}, ${DateFormat("HH:mm").format(toLocal())}';
  }
}

extension CapExtension on String {
  String get inCaps => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.inCaps).join(" ");
}

String twoDigit(int val) {
  if (val < 10) {
    return "0$val";
  } else {
    return "$val";
  }
}

extension FormatString on String {
  String twoDigit() {
    if (this == '') {
      return '';
    } else if (this == '-') {
      return '-';
    }
    if (int.parse(this) < 10) {
      return "0$this";
    } else {
      return this;
    }
  }

  String formatRupiah() {
    if (this == '') {
      return '';
    } else if (this == '-') {
      return '-';
    } else {
      final oCcy = NumberFormat(" #,##0", "id_ID");
      return oCcy.format(int.parse(this));
    }
  }

  String toFormattedDate() {
    if (this == '' || this == '-') return this;
    DateTime dateTime = DateTime.parse(this).toLocal();
    return dateTime.toFormattedDate();
  }

  String checkServer() {
    if (this == "null : XMLHttpRequest error.") return 'Server Maintenance';
    return this;
  }

  String maskLastString({int number = 3, String mask = 'x'}) {
    if (this == '' || this == '-') return this;
    return replaceRange(length - number, length, mask * number);
  }

  String toFormattedDateHour() {
    if (this == '' || this == '-') return this;
    initializeDateFormatting();
    DateTime date = DateTime.parse(this).toLocal();
    return '${DateFormat.yMMMMd('id').format(date)}, ${DateFormat("HH:mm").format(date)}';
  }

  DateTime toDateTime() {
    return DateTime.parse(this).toLocal();
  }

  String toJamMenit() {
    if (this == '' || this == '-') return this;
    return '${split(":")[0]}:${split(":")[1]}';
  }

  String checkStatusTicket() {
    DateTime date = DateTime.parse(this).toLocal();
    var temp = DateTime.now().toLocal();
    var d1 = DateTime.utc(temp.year, temp.month, temp.day);
    var d2 = DateTime.utc(date.year, date.month, date.day);
    if (d2.compareTo(d1) < 0) {
      return "Expired";
    } else {
      return "Active";
    }
  }
}

extension MyTextExtension on TextStyle {
  TextStyle? white({double? opacity}) {
    return copyWith(color: Colors.white.withOpacity(opacity ?? 1));
  }

  TextStyle bold({FontWeight? weight}) {
    return copyWith(fontWeight: weight ?? FontWeight.bold);
  }
}

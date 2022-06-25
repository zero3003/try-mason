import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// use these to log data
bool type = !kReleaseMode;

/// use bool type = true; to always log even in release mode
loggerI(dynamic message) {
  if (type) logger.i(message);
}

loggerW(dynamic message) {
  if (type) logger.w(message);
}

loggerE(dynamic message) {
  if (type) logger.e(message);
}

loggerD(dynamic message) {
  if (type) logger.d(message);
}

loggerV(dynamic message) {
  if (type) logger.v(message);
}

loggerWtf(dynamic message) {
  if (type) logger.wtf(message);
}

var logger = Logger(
  // Use the default LogFilter (-> only log in debug mode)
  // printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  printer: PrettyPrinter(
    methodCount: 0,
  ), // Use the default LogOutput (-> send everything to console)
);

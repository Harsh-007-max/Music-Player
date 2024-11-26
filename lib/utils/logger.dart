import 'package:logger/logger.dart';

var logger = Logger(printer:PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
  )
);

// The logger allows you to log messages at various levels of severity. You can use different log levels depending on the importance or verbosity of the message. Here are the most common log levels:

// logger.v() — Verbose logs (detailed information for debugging).
// logger.d() — Debug logs (less detailed, useful for development).
// logger.i() — Information logs (general messages).
// logger.w() — Warning logs (something might go wrong).
// logger.e() — Error logs (exception or error message).
// logger.wtf() — WTF logs (something unexpected happened).



import 'logging.dart';

void throwToolExit(String message, { int exitCode }) {
  throw ToolExit(message, exitCode: exitCode);
}

class ToolExit implements Exception {
  ToolExit(this.message, { this.exitCode });

  final String message;
  final int exitCode;

  @override
  String toString() => 'Exception: $message';
}

extension LoggerUtil on Logger {
  void divider() {
    this.stdout('-----------------------------------');
  }

  Progress progressSection(String message) {
    return this.progress(' • $message');
  }

  void stdoutSection(String message) {
    return this.stdout(' • $message');
  }
}

extension ProgressUtil on Progress {
  void finishWithTick() {
    this.finish(message: '✔️');
  }

  void finishWithError() {
    this.finish(message: '⨯');
  }
}
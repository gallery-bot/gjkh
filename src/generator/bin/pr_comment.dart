

import 'dart:io';

import 'generator.dart';

void main () {

  final changesJson = File(buildPath + 'changes.json').readAsStringSync();
  stdout.write(r'**tetst** ${changesJson} \n test');
}

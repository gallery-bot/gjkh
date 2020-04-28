import 'dart:io';

import 'package:yaml/yaml.dart';
import 'generator.dart';
import 'pr_comment.dart';
import 'project/project.dart';
import 'utils/logging.dart';
import 'version_control.dart';
import 'utils/common.dart';



Logger logger;

void main(List<String> args) async {
  bool verbose = args.contains('-v');

  logger = verbose ? new Logger.verbose() : new Logger.standard();

  logger.stdout('Welcome to Awesome Flutter Gallery 💙');

  final vs = VersionControl();


  logger.divider();

  String result = r'##Awesome Gallery Projects<br/><br/>Interact with flutter projects and packages.<br/>';

  result += generateTable('Projects', vs.projects.values.toList());


  File(galleryPath + 'README.md').writeAsStringSync(result);
}

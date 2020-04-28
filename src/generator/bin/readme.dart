import 'dart:io';

import 'package:yaml/yaml.dart';
import 'generator.dart';
import 'pr_comment.dart';
import 'project/project.dart';
import 'utils/logging.dart';
import 'version_control.dart';
import 'utils/common.dart';



void main(List<String> args) async {
  bool verbose = args.contains('-v');

  logger = verbose ? new Logger.verbose() : new Logger.standard();

  logger.stdout('Welcome to Awesome Flutter Gallery 💙');

  final vs = VersionControl();


  logger.divider();

  String result = '''# Awesome Gallery \n 
  Interact with your flutter projects and packages and share them with just a link <br/>''';

  result += generateTable('Projects', vs.projects.values.toList());


  File(galleryPath + 'README.md').writeAsStringSync(result);
}

import 'dart:io';

import '../generator.dart';
import 'generate.dart';
import 'project.dart';
import '../utils/common.dart';
import '../utils/directory.dart';

Future removeProject(Project project) async {
  await removeWebProject(project);
}

Future removeWebProject(Project project) async {
  final webPath = webRelativePath + project.path + project.id;
  await Directory(webPath).removeIfExists();
}

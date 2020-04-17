


import 'dart:io';

import 'package:yaml/yaml.dart';

import '../common.dart';
import 'project.dart';

List<Project> parseProjectList({String dir, String filePath}) {
  final absolutePath = '$dir$filePath';
  try {
    if (!absolutePath.endsWith('yaml')) {
      throwToolExit('File format is not yaml');
    }

    final projectPath = filePath.replaceFirst('.yaml', '/');
    final String content = File(absolutePath).readAsStringSync();
    final YamlMap yaml = loadYamlNode(content);

    final projects = yaml.map((key, value) =>
        MapEntry(key, Project.fromYaml(key, projectPath, value)));
    return projects.values.toList();
  } catch (e) {
    throwToolExit('An error ocurred while parsing yaml: $filePath \n $e');
    return null;
  }
}

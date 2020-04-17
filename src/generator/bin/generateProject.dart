import 'dart:io';

import 'package:yaml/yaml.dart';
import 'project/generate.dart';
import 'utils/directory.dart';

import 'common.dart';
import 'project/build.dart';
import 'project/parse.dart';
import 'project/project.dart';
import 'utils/logging.dart';

const galleryPath = '../../';
const projectsRelativePath = '${galleryPath}projects/';
//const buildRelativePath = '${galleryPath}build/';
const webRelativePath = '${galleryPath}web/';

Logger logger;

void main(List<String> args) async {
  bool verbose = args.contains('-v');

  logger = verbose ? new Logger.verbose() : new Logger.standard();

  logger.stdout('Welcome to Awesome Flutter Gallery 💙');
  final pathToGenerate = 'nisrulz/flutter-examples.yaml';

  Progress progress = logger.progress('Parsing section $pathToGenerate');
  List<Project> projects = parseProjectList(
      dir: projectsRelativePath, filePath: 'nisrulz/flutter-examples.yaml');
  progress.finish(message: '', showTiming: false);
  logger.stdout('${projects.length} Projects found');
  logger.divider();

  for (final project in [projects.last]) {
    logger.stdout('Generating project: ${project.title}');
    await cloneProject(project);
    await addPackageToProject(project);
    await prepareProject(project);
    await buildProject(project);
    await moveWebProject(project);
    logger.stdout('Project succesfully created 🎉');
    logger.divider();
  }
}

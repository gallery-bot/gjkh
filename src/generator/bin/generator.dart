import 'dart:io';

import 'package:yaml/yaml.dart';
import 'project/generate.dart';
import 'project/remove.dart';
import 'utils/directory.dart';

import 'utils/common.dart';
import 'project/build.dart';
import 'project/parse.dart';
import 'project/project.dart';
import 'utils/logging.dart';
import 'version_control.dart';

const galleryPath = '../../';
const projectsRelativePath = '${galleryPath}projects/';
//const buildRelativePath = '${galleryPath}build/';
const webRelativePath = '${galleryPath}build/web/';
const buildPath = '${galleryPath}build/';

Logger logger;

void main(List<String> args) async {
  bool verbose = args.contains('-v');

  logger = verbose ? new Logger.verbose() : new Logger.standard();

  logger.stdout('Welcome to Awesome Flutter Gallery 💙');

  final vs = VersionControl();


  logger.divider();

  for (final  change in vs.changes) {
    final Project project = change.project;
    if(change.change == VersionChange.delete) {
      await removeProject(project);
      return;
    } else if (change.change == VersionChange.update) {
      await removeProject(project);
    }

    logger.stdout('Generating project: ${project.title}');
    await cloneProject(project);
    await addPackageToProject(project);
    await prepareProject(project);
    await buildProject(project);
    await moveWebProject(project);
    logger.stdout('Project succesfully created 🎉');
    logger.divider();
  }

  logger.stdout('All projects where created succesfully. 💙');
}

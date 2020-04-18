


import 'dart:io';

import '../utils/logging.dart';
import 'project.dart';
import '../utils/common.dart';
import '../utils/directory.dart';
import '../generator.dart';

final tempDirectory = '${galleryPath}temp/';

Future cloneProject(Project project) async {


  final projectPath = tempDirectory + project.path + project.gitProject.path;

  final process = logger.progressSection('Clonning project in $projectPath');

  Directory(tempDirectory).removeIfExistsSync();
  Directory(tempDirectory).createIfNotExistSync();
  await Process.run(
      'git',
      [
        'clone',
        project.gitProject.url,
        project.path,
      ],
      workingDirectory: tempDirectory,
      runInShell: true);

  process.finishWithTick();

 /* final buildPath = buildRelativePath + project.path + project.id + '/';
  final moveProjectProgress = logger.progressSection('Move project to $buildPath');

  Directory(buildPath).createIfNotExistSync();
  Directory(buildPath).removeIfExistsSync();
  Directory(projectPath).renameSync(buildPath);

  moveProjectProgress.finishWithTick();*/

}



Future addPackageToProject(Project project) async {
  final projectPath = tempDirectory + project.path + project.gitProject.path;

  final autoGenerateProgress = logger.progressSection('Adding flutter_showcase package in $projectPath');

  final result = await Process.start('flutter',
      ['pub', 'run', 'flutter_showcase:autogenerate', '--dir=$projectPath'],
      runInShell: true);

  if(logger.isVerbose) await stdout.addStream(result.stdout);
 final exitCode = await result.exitCode;
 if(exitCode != 0) {
    autoGenerateProgress.finishWithError();

   await stderr.addStream(result.stderr);
   exit(255);
 }

  autoGenerateProgress.finishWithTick();
}



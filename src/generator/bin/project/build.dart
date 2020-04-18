



import 'dart:io';
import '../utils/directory.dart';
import '../generator.dart';
import 'generate.dart';
import 'project.dart';
import '../utils/common.dart';


Future prepareProject(Project project) async {
  final projectPath = tempDirectory + project.path + project.gitProject.path;

  if(!File('${projectPath}web/index.html').existsSync()) {
    final progress = logger.progressSection('Adding web support for flutter project');
    final getPackages = await Process.start('flutter',
        ['create', '.'],
        workingDirectory: projectPath,
        runInShell: true);

    await stderr.addStream(getPackages.stderr);
    await getPackages.exitCode;
    progress.finishWithTick();
  } else {
    logger.stdoutSection('Flutter project supports web ✔️');
  }
  final progress = logger.progressSection('Installing packages');
  final getPackages = await Process.start('flutter',
      ['pub', 'get'],
      workingDirectory: projectPath,
      runInShell: true);

  await stderr.addStream(getPackages.stderr);
  // await stdout.addStream(getPackages.stdout);
  await getPackages.exitCode;
  progress.finishWithTick();


}


Future buildProject(Project project) async {
  final projectPath = tempDirectory + project.path + project.gitProject.path;

  final buildProgress = logger.progressSection('Building project');
  final result = await Process.start('flutter',
      ['pub', 'run', 'flutter_showcase', 'build'],
      workingDirectory: projectPath,
      runInShell: true);
  if(logger.isVerbose) await stdout.addStream(result.stdout);
  final exitCode = await result.exitCode;
  if(exitCode == 0) {
    buildProgress.finishWithTick();
  } else {
    buildProgress.finishWithError();
    logger.stderr('An error occurred while building the project');
    await stderr.addStream(result.stderr);
    throwToolExit('');
  }

}



Future moveWebProject(Project project) async {
  final projectPath = tempDirectory + project.path + project.gitProject.path;

  final webPath = webRelativePath + project.path + project.id;

  final moveProjectProgress = logger.progressSection('Move web project to $webPath');

  Directory(webPath).createIfNotExistSync();
  Directory(webPath).removeIfExistsSync();
  Directory('${projectPath}build/web_showcase').renameSync(webPath);

  moveProjectProgress.finishWithTick();

}

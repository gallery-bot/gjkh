import 'dart:convert';
import 'dart:io';

import 'generator.dart';
import 'project/project.dart';
import 'version_control.dart';

void main() {
  final changesJson = File(buildPath + 'changes.json').readAsStringSync();
  List<dynamic> json = jsonDecode(changesJson);
  List<ProjectChangeHistory> changes =
      json.map((e) => ProjectChangeHistory.fromJson(e)).toList();

  String result = r'#### Gallery Version Control<br/><br/>Projects will be available after the Pull Request is merged.<br/>';
  if (changes.isEmpty)
    result += r'No changes were found in any project<br/>';
  else {
    final updatedProjects =
        changes.where((element) => element.change == VersionChange.update).toList();
    final createdProjects =
        changes.where((element) => element.change == VersionChange.create).toList();
    final deletedProjects =
        changes.where((element) => element.change == VersionChange.delete).toList();

    if (createdProjects.isNotEmpty) {
      result += generateTable('Created Projects', createdProjects.map((e) => e.project).toList());
    }

    if (updatedProjects.isNotEmpty) {
      result += generateTable('Updated Projects', updatedProjects.map((e) => e.project).toList());
    }
    if (deletedProjects.isNotEmpty) {
      result += simpleTable('Deleted Projects', deletedProjects);
    }
  }

  stdout.write(result);

  //stdout.write(+changesJson + r'<br/> test');
}

String generateTable(String title, List<Project> items) {
  String result = '<table style="width:100%"><tr><th>' +
      title +
      _spaces +
      '</th>' +
      '</tr>';

  for (final project in items) {
    final url = 'https://gallery-bot.github.io/gjkh/' +
        project.path +
        project.id +
        '/';

    result += '<tr>' +
        r'<td>' +
        r'<img height="128" width="200" align="left" src="' +
        '${url}social_media.png' +
        '?raw=true">' +
        '<h3>${project.title}</h3>' +
        '<a href="$url" >' +
        r'See Showcase' +
        r'</a>' +
        r'</td>' +
        r'</tr>';
  }
  result += '</table><br/>';
  return result;
}

String simpleTable(String title, List<ProjectChangeHistory> items) {
  String result = '<table style="width:100%"><tr><th>' +
      title +
      _spaces +
      '</th>' +
      '</tr>';

  for (final project in items) {
    result += '<tr>' +
        r'<td>' +
        '<b>${project.project.title}</b>' +
        r'</td>' +
        r'</tr>';
  }
  result += '</table><br/>';
  return result;
}

const _spaces =
    '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';

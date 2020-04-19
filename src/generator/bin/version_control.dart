import 'dart:convert';
import 'dart:io';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

import 'generator.dart';
import 'project/parse.dart';
import 'project/project.dart';
import 'utils/logging.dart';
import 'utils/common.dart';

void main(List<String> args) {
  bool verbose = args.contains('-v');
  logger = verbose ? new Logger.verbose() : new Logger.standard();
  VersionControl();
}

class VersionControl {
  List<ProjectChangeHistory> changes;

  VersionControl() {
    generateProjectList();
  }

  void generateProjectList() {
    Progress progress = logger.progress('Parsing projects');
    final rootDirectory = Directory(projectsRelativePath);
    final Map<String, Project> projects = {};

    final list = rootDirectory.listSync(recursive: true);

    list.forEach((file) {
      if (file is File && file.path.endsWith('.yaml')) {
        final path = file.path.replaceFirst(projectsRelativePath, '');
        final fileProjects =
            parseProjectList(dir: projectsRelativePath, filePath: path);
        fileProjects.forEach((project) {
          final key = project.path + project.id + '/';
          if (projects[key] != null) {
            throw ('Project ${project.id} already exits in ${project.path}.yaml');
          }
          projects[key] = project;
        });
      }
    });
    progress.finishWithTick();
    logger.stdout('Found ${projects.length} projects');
    String historyContent = jsonEncode(projects);

    final file = File('${projectsRelativePath}projects.json');
    Map<String, Project> oldProjects = {};
    if (file.existsSync()) {
      final oldHistory = file.readAsStringSync();
      Map<String, dynamic> json = jsonDecode(oldHistory);
      oldProjects =
          json.map((key, value) => MapEntry(key, Project.fromJson(value)));
    }
    File('${projectsRelativePath}projects.json')
        .writeAsStringSync(historyContent);

    Progress compareVersionProgress = logger.progress('Check  projects');

    try {
      changes = compareVersions(projects, oldProjects);
      compareVersionProgress.finishWithTick();
      logger.stdout('Found changes in ${changes.length} projects');

      File('${buildPath}changes.json')
          .writeAsStringSync(jsonEncode(changes.map((e) => e.toJson()).toList()));
    } catch (e) {
      compareVersionProgress.finishWithError();
      logger.stderr('Error while checking changes in projects');
      rethrow;
    }
  }

  List<ProjectChangeHistory> compareVersions(
    Map<String, Project> newProjects,
    Map<String, Project> oldProjects,
  ) {
    Set<String> removedKeys = oldProjects.keys.toSet();
    removedKeys.removeAll(newProjects.keys.toSet());

    Set<String> addedKeys = newProjects.keys.toSet();
    addedKeys.removeAll(oldProjects.keys.toSet());

    final newEntriesSet =
        newProjects.entries.map((e) => EquatableMapEntry.from(e)).toSet();
    final oldEntriesSet =
        oldProjects.entries.map((e) => EquatableMapEntry.from(e)).toSet();
    Set<EquatableMapEntry<String, Project>> changedProjects = newEntriesSet;
    changedProjects.removeAll(oldEntriesSet);

    return [
      ...removedKeys.map((key) {
        final project = oldProjects[key];
        logger.stdoutSection('Deleted: ${project.title}');
        return ProjectChangeHistory(project, VersionChange.delete);
      }),
      ...addedKeys.map((key) {
        final project = newProjects[key];
        logger.stdoutSection('Created: ${project.title}');
        return ProjectChangeHistory(project, VersionChange.create);
      }),
      ...changedProjects.where((entry) => oldProjects[entry.key] != null).map(
        (entry) {
          final project = entry.value;
          logger.stdoutSection('Updated: ${project.title}');
          return ProjectChangeHistory(project, VersionChange.update);
        },
      ),
    ];
  }
}

enum VersionChange { delete, update, create }

class ProjectChangeHistory {
  final VersionChange change;
  final Project project;

  ProjectChangeHistory(
    this.project,
    this.change,
  );

  Map<String, dynamic> toJson() =>
      {'change': EnumToString.parse(change), 'project': project.toJson()};

  factory ProjectChangeHistory.fromJson(Map<String, dynamic> json) {
    return ProjectChangeHistory(
      Project.fromJson(
        Map<String, dynamic>.from(json['project']),
      ),
      EnumToString.fromString(VersionChange.values, json['change']),
    );
  }
}

class EquatableMapEntry<K, V> extends Equatable {
  /** The key of the entry. */
  final K key;

  /** The value associated to [key] in the map. */
  final V value;

  /** Creates an entry with [key] and [value]. */
  const factory EquatableMapEntry(K key, V value) = EquatableMapEntry<K, V>._;

  /** Creates an entry with [key] and [value]. */
  factory EquatableMapEntry.from(MapEntry<K, V> entry) =>
      EquatableMapEntry<K, V>._(entry.key, entry.value);

  const EquatableMapEntry._(this.key, this.value);

  String toString() => "MapEntry($key: $value)";

  @override
  List<Object> get props => [key, value];
}




import 'package:yaml/yaml.dart';

class Project {
  final String title;
  final String description;
  final String id;
  final String path;
  final GitProject gitProject;

  Project({
    this.path,
    this.title,
    this.description,
    this.id,
    this.gitProject,
  });

  factory Project.fromYaml(String id, String path, YamlMap yaml) {
    return Project(
      id: id,
      path: path,
      description: yaml['description'],
      title: yaml['title'],
      gitProject: GitProject.fromYaml(yaml['git']),
    );
  }
}

class GitProject {
  final String url;
  final String path;

  GitProject({this.url, this.path = ''});

  factory GitProject.fromYaml(YamlNode yaml) {
    if (yaml is YamlMap) {
      return GitProject(
        url: yaml['url'],
        path: yaml['path'] ?? '',
      );
    } else if (yaml is YamlScalar) {
      return GitProject(url: yaml.value);
    } else {
      throw ('Invalid yaml git format project,\n $yaml');
      return null;
    }
  }
}

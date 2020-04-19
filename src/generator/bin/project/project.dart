import 'package:equatable/equatable.dart';
import 'package:yaml/yaml.dart';

class Project extends Equatable {
  final String title;
  final String description;
  final String id;
  final String path;
  final String version;
  final Map<String, String> links;
  final GitProject gitProject;

  Project({
    this.path,
    this.title,
    this.description,
    this.version,
    this.id,
    this.gitProject,
    this.links = const {},
  });

  factory Project.fromYaml(String id, String path, YamlMap yaml) {
    Map<String, String> getLinks() {
      final links = yaml['links'];
      if (links is YamlMap) {
        return Map<String, String>.from(links);
      }
      return null;
    }

    return Project(
      id: id,
      path: path,
      version: yaml['version'].toString() ?? '',
      description: yaml['description'],
      title: yaml['title'],
      links: getLinks(),
      gitProject: GitProject.fromYaml(yaml['git']),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      path: json['path'],
      description: json['description'],
      title: json['title'],
      version: json['version'],
      gitProject: GitProject.fromJson(Map<String, dynamic>.from(json['git'])),
      links: json['links'] != null
          ? Map<String, String>.from(json['links'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'description': description,
      'id': id,
      'version': version,
      'title': title,
      'git': gitProject,
      'links': links
    };
  }

  @override
  List<Object> get props => [id, path, description, title, gitProject, version];

  @override
  bool get stringify => true;
}

class GitProject extends Equatable {
  final String url;
  final String path;

  String get fullPath => url + path;

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

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': path,
    };
  }

  GitProject.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        path = json['path'];

  @override
  List<Object> get props => [url, path];

  @override
  bool get stringify => true;
}

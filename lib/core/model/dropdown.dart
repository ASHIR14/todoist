import 'package:todoist/core/model/project.dart';

class DropdownModel {
  String id = "";
  String name = "";
  bool isSelected = false;

  DropdownModel({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  DropdownModel.fromProject(Project project) {
    id = project.id;
    name = project.name;
    isSelected = false;
  }
}

import 'package:uuid/uuid.dart';

class OptionModel {
  String? id = const Uuid().v4();
  String name;

  OptionModel({this.id , required this.name});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class OptionModel {
  bool isCorrect;
  String name;

  OptionModel({this.isCorrect = false , required this.name});

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      isCorrect: json['isCorrect'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCorrect': isCorrect,
      'name': name,
    };
  }
}
import 'package:flutter/foundation.dart';

enum SurveyQuestionType {
  shortText,
  longText,
  multipleChoice,
  image,
  pdf,
}

class SurveyQuestion {
  final String title;
  final SurveyQuestionType type;
  final List<String>? choices;
  String? answer;

  SurveyQuestion({
    required this.title,
    required this.type,
    this.choices,
    this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': describeEnum(type),
      'choices': choices,
      'answer': answer,
    };
  }

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      title: json['title'],
      type: SurveyQuestionType.values.firstWhere(
            (type) => describeEnum(type) == json['type'],
      ),
      choices: List<String>.from(json['choices']),
      answer: json['answer'],
    );
  }
}
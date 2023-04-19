import 'package:flutter/material.dart';
import 'SurveyQuestionType.dart';

class SurveyPage extends StatelessWidget {
  final String title;
  final List<SurveyQuestion> questions;

  const SurveyPage({Key? key, required this.title, required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (BuildContext context, int index) {
          final question = questions[index];
          return Column(
            children: [
              ListTile(
                title: Text(question.title),
                subtitle: _buildQuestionWidget(question),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestionWidget(SurveyQuestion question) {
    switch (question.type) {
      case SurveyQuestionType.shortText:
        return TextField(
          decoration: InputDecoration(
            hintText: 'Type your answer here',
          ),
          onChanged: (value) {
            question.answer = value;
          },
        );
      case SurveyQuestionType.longText:
        return TextField(
          decoration: InputDecoration(
            hintText: 'Type your answer here',
          ),
          maxLines: null,
          onChanged: (value) {
            question.answer = value;
          },
        );
        /*
      case SurveyQuestionType.multipleChoice:
        return Column(
          children: question.choices
              .map((choice) => RadioListTile(
            title: Text(choice),
            value: choice,
            groupValue: question.answer,
            onChanged: (value) {
              question.answer = value;
            },
          ))
              .toList(),
        );*/
      default:
        return SizedBox.shrink();
    }
  }
}
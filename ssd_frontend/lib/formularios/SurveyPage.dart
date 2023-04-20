/*import 'package:flutter/material.dart';
import 'SurveyQuestionType.dart';

class SurveyState extends State<Survey> {
  List<Map<String, dynamic>> _answers = [];

  void _submit() {
    widget.onSubmit(_answers as Map<String, dynamic>);
  }

  void _answerQuestion(String title, dynamic answer) {
    final question = _answers.firstWhere(
          (q) => q['title'] == title,
      orElse: () => {'title': title},
    );
    question['answer'] = answer;
    if (!_answers.contains(question)) {
      _answers.add(question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.pages.length,
            itemBuilder: (BuildContext context, int pageIndex) {
              final page = widget.pages[pageIndex];
              return ListView.builder(
                itemCount: page.questions.length,
                itemBuilder: (BuildContext context, int questionIndex) {
                  final question = page.questions[questionIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          question.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: _buildQuestionWidget(question),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: _submit,
            child: Text('Submit'),
          ),
        ),
      ],
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
            _answerQuestion(question.title, value);
          },
        );
      case SurveyQuestionType.longText:
        return TextField(
          decoration: InputDecoration(
            hintText: 'Type your answer here',
          ),
          maxLines: null,
          onChanged: (value) {
            _answerQuestion(question.title, value);
          },
        );

      case SurveyQuestionType.multipleChoice:
        return Column(
          children: question.choices
              !.map((choice) => RadioListTile(
            title: Text(choice),
            value: choice,
            groupValue: _answers
                .firstWhere((q) => q['title'] == question.title,
                orElse: () => {'answer': null})['answer'],
            onChanged: (value) {
              _answerQuestion(question.title, value);
            },
          ))
              .toList(),
        );
      default:
        return SizedBox.shrink();
    }
  }
}

class Survey extends StatefulWidget {
  final List<SurveyPage> pages;
  final void Function(Map<String, dynamic>) onSubmit;

  Survey({required this.pages, required this.onSubmit});

  @override
  _SurveyState createState() => _SurveyState();
}

class SurveyPage {
  getData() {}
}

class _SurveyState extends State<Survey> {
  int _currentPageIndex = 0;
  final Map<String, dynamic> _formData = {};

  void _submitPage(Map<String, dynamic> pageData) {
    _formData.addAll(pageData);
    if (_currentPageIndex < widget.pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    } else {
      widget.onSubmit(_formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: widget.pages[_currentPageIndex],
            ),
            ElevatedButton(
              onPressed: () {
                if (_currentPageIndex > 0) {
                  setState(() {
                    _currentPageIndex--;
                  });
                }
              },
              child: Text('Previous'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final pageData = widget.pages[_currentPageIndex].getData();
                _submitPage(pageData);
              },
              child: _currentPageIndex < widget.pages.length - 1
                  ? Text('Next')
                  : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}*/








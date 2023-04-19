import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

// Define a custom Form widget.
class FormRestaurante extends StatefulWidget {
  const FormRestaurante({super.key, required this.title});

  final String title;

  @override
  State<FormRestaurante> createState() => _FormRestauranteState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _FormRestauranteState extends State<FormRestaurante> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<_FormRestauranteState> _surveyKey = GlobalKey<_FormRestauranteState>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext) {
   return Scaffold(
     key: _scaffoldKey,

     appBar: AppBar(
       title: Text('Anúncio - Serviço de Restauração'),
     ),

     body: SafeArea(
         child: Survey(
           key: _surveyKey,
            //onSubmit: _submitSurvey,
            initialData: [
              /*
              SurveyPage(
                title: 'Page1',
                questions: [
                  SurveyQuestion(
                    title:
                  ),
                ]
              ),*/
            ],
         ),
     ),

   );
  }



  /*
  File? _imageFile = null;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Picked file path: ${pickedFile.path}');
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No file picked');
    }

  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [

    Question(
        isMandatory: true,
        question: 'Morada do Serviço:'
    ),

    Question(
        isMandatory: true,
        question: 'Contactos'
    ),

    Question(
      isMandatory: true,
      question: 'Do you like drinking coffee?',
      answerChoices: {
        "Yes": [
          Question(
              singleChoice: false,
              question: "What are the brands that you've tried?",
              answerChoices: {
                "Nestle": null,
                "Starbucks": null,
                "Coffee Day": [
                  Question(
                    question: "Did you enjoy visiting Coffee Day?",
                    isMandatory: true,
                    answerChoices: {
                      "Yes": [
                        Question(
                          question: "Please tell us why you like it",
                        )
                      ],
                      "No": [
                        Question(
                          question: "Please tell us what went wrong",
                        )
                      ],
                    },
                  )
                ],
              })
        ],
        "No": [
          Question(
            question: "Do you like drinking Tea then?",
            answerChoices: {
              "Yes": [
                Question(
                    question: "What are the brands that you've tried?",
                    answerChoices: {
                      "Nestle": null,
                      "ChaiBucks": null,
                      "Indian Premium Tea": [
                        Question(
                          question: "Did you enjoy visiting IPT?",
                          answerChoices: {
                            "Yes": [
                              Question(
                                question: "Please tell us why you like it",
                              )
                            ],
                            "No": [
                              Question(
                                question: "Please tell us what went wrong",
                              )
                            ],
                          },
                        )
                      ],
                    })
              ],
              "No": null,
            },
          )
        ],
      },
    ),
    Question(
        question: "What age group do you fall in?",
        isMandatory: true,
        answerChoices: const {
          "18-20": null,
          "20-30": null,
          "Greater than 30": null,
        })
  ];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(

      ),
      body:

          /*
          ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Form(
                  key: _formKey,
                  child: Survey(
                      onNext: (questionResults) {
                        _questionResults = questionResults;
                      },
                      initialData: _initialData),
                ),

                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 100.0,
                  )
                else
                  Text('No image selected.'),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select Image'),
                ),


              ],
            ),*/


          bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent, // Background Color
                  ),
                child: const Text("Validate"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                  //do something

                  }
                },
              ),
            ),
          ],
      ),
    );
  } */
}



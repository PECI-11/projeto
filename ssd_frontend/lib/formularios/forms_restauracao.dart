import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';


import 'ConfirmationPage.dart';

class RestaurantForm extends StatefulWidget {
  @override
  _RestaurantFormState createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tipoEstabelecimentoController = TextEditingController();
  TextEditingController _imagesController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _promoController = TextEditingController();
  List<File> _imageList = [];
  List<String> _imageDescriptionList = [];

  final String url = 'http://127.0.0.1:8000/services/restaurants';
  final List<String> _restaurantTypes = ["Restaurante", "Café", "Bar", "Snack-Bar", "Salão de chá", "Food Truck", "Self-service"];

  List<String> _selectedTypes = [];

  void _toggleType(String type) {
    setState(() {
      if (_selectedTypes.contains(type)) {
        _selectedTypes.remove(type);
      } else {
        _selectedTypes.add(type);
      }
    });
  }

  Future _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageList.add(File(pickedFile.path));
        _imageDescriptionList.add("");
      }
    });
  }

  /*Future _getPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    setState(() {
      if (result != null) {
        _imageList.add(File(result.files.single.path!));
        _imageDescriptionList.add("");
        print('PDF done');
      }
    });
  }*/
  Widget _buildRestaurantTypeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo de estabelecimento"),
        SizedBox(height: 10.0),
        Column(
          children: _restaurantTypes
              .map(
                (type) => Row(
                  children: <Widget> [
                    Checkbox(
                      value: _selectedTypes.contains(type),
                      onChanged: (value){
                        setState(() {
                          if(value!){
                            _selectedTypes.add(type);
                          }
                          else{
                            _selectedTypes.remove(type);
                          }
                        });
                      }
                  ),
                  Text(type),
                ],
              ),
            )
            .toList(),
        ),
      ],
    );
  }

  Widget _buildImagesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Ementa"),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            _getImage(ImageSource.gallery);
          },
          child: Text("Inserir imagem da ementa"),
        ),
        SizedBox(height: 10.0),
        if (_imageList.isNotEmpty)
          Column(
            children: List.generate(_imageList.length, (index) {
              return Column(
                children: [
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Image.network(
                        _imageList[index].path,
                        height: 100.0,
                        width: 100.0,
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
      ],
    );
  }


  Widget _buildHoursInput() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Horário de funcionamento"),
          SizedBox(height: 10.0),
          TextFormField(
            controller: _hoursController,
            decoration: InputDecoration
            (
              border: OutlineInputBorder(),
              hintText: "Insira o horário de funcionamento",
            ),
           validator: (value) {
              if (value == "") {
                return "Insira o horário de funcionamento";
              }
              return null;
           },
          ),
        ],
      );
    }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Descrição do ambiente"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira uma descrição do ambiente",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira uma descrição do ambiente";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLocationInput() {
    LatLng _restaurantLocation = LatLng(0.0, 0.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Localização exata"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira a localização do restaurante",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira a localização do restaurante";
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildPromoInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Promoções / ofertas especiais"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _promoController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira as promoções / ofertas especiais",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira as promoções / ofertas especiais";
            }
            return null;
          },
        ),
      ],
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Formulário do restaurante"),
    ),
    body: Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildRestaurantTypeInput(),
            SizedBox(height: 16.0),
            _buildImagesInput(),
            SizedBox(height: 20.0),
            _buildHoursInput(),
            SizedBox(height: 20.0),
            _buildDescriptionInput(),
            SizedBox(height: 20.0),
            _buildLocationInput(),
            SizedBox(height: 20.0),
            _buildPromoInput(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm, // Updated here
              child: Text("Enviar"),
            ),
          ],
        ),
      ),
    ),
  );
}

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    // Get the currently logged-in user's email
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "";

    // Encode the form data and user email as a JSON object
    final data = json.encode({
      'tipoEstabelecimento': _tipoEstabelecimentoController.text,
      'ementa': _imagesController.text,
      'hours': _hoursController.text,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'promo': _promoController.text,
      'images': _imageList.map((e) => e.path).toList(),
      'imageDescriptions': _imageDescriptionList,
      'email': email,
    });

    // Send the form data to the server
    final response = await http.post(
      Uri.parse(url),
      body: data,
    );

    if (response.statusCode == 200) {
      // Success: navigate to the confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(
            confirmationText: '',
          ),
        ),
      );
    } else {
      // Error: display an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Não foi possível enviar os dados do formulário.'),
            actions: <Widget>[
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}


  Widget _buildSubmitButton() {
    return ElevatedButton(
  onPressed: _submitForm,
  child: Text("Enviar"),
);

  }
}

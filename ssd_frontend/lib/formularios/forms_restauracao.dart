import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ConfirmationPage.dart';

class RestaurantForm extends StatefulWidget {
  @override
  _RestaurantFormState createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _menuController = TextEditingController();
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _promoController = TextEditingController();
  List<File> _imageList = [];
  List<String> _imageDescriptionList = [];

  // NÃO SEI QUE NOME É SUPOSTO DAR!
  final String url = 'https://meuendpoint.com/api/restaurants';

  Future _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageList.add(File(pickedFile.path));
        _imageDescriptionList.add("");
      }
    });
  }

  Future _getPDF() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    setState(() {
      if (result != null) {
        _imageList.add(File(result.files.single.path!));
        _imageDescriptionList.add("");
      }
    });
  }

  Widget _buildMenuInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Ementa"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _menuController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira um arquivo PDF ou uma imagem da ementa",
          ),
          validator: (value) {
            if (_imageList.isEmpty && value == "") {
              return "Insira um arquivo PDF ou uma imagem da ementa";
            }
            return null;
          },
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text("Escolha uma opção"),
                  children: <Widget>[
                    SimpleDialogOption(
                      child: Text("Imagem"),
                      onPressed: () {
                        _getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                    SimpleDialogOption(
                      child: Text("PDF"),
                      onPressed: () {
                        _getPDF();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(height: 10.0),
        if (_imageList.isNotEmpty)
          Column(
            children: List.generate(_imageList.length, (index) {
              return Column(
                children: [
                  Image.file(_imageList[index]),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: _imageDescriptionList[index],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Descrição da imagem",
                    ),
                    onChanged: (value) {
                      _imageDescriptionList[index] = value;
                    },
                  ),
                  SizedBox(height: 10.0),
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
        Container(
          height: 200.0,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _restaurantLocation,
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {},
            markers: {
              Marker(
                markerId: MarkerId("restaurant_location"),
                position: _restaurantLocation,
              ),
            },
          ),
        ),
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
    _buildMenuInput(),
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
    onPressed: () {
    if (_formKey.currentState!.validate()) {
// Do something with the form data
    print("Menu: ${_menuController.text}");
    print("Horário: ${_hoursController.text}");
    print("Descrição do ambiente: ${_descriptionController.text}");
    print("Localização: ${_locationController.text}");
    print("Promoções_controller.text}");
    }
    },
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
      // Enviar solicitação HTTP POST com os dados do formulário
      final response = await http.post(
        Uri.parse(url),
        body: {
          'menu': _menuController.text,
          'hours': _hoursController.text,
          'description': _descriptionController.text,
          'location': _locationController.text,
          'promo': _promoController.text,
          'images': json.encode(_imageList.map((e) => e.path).toList()),
          'imageDescriptions': json.encode(_imageDescriptionList),
        },
      );
      if (response.statusCode == 200) {
        // Dados enviados com sucesso
        // Redirecionar para a página de confirmação
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConfirmationPage(confirmationText: '',)),
        );
      } else {
        // Erro ao enviar dados
        // Exibir mensagem de erro
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
      child: Text('Enviar'),
      onPressed: _submitForm,
    );
  }
}






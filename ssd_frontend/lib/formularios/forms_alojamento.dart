import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:typed_data';




class AlojamentoForm extends StatefulWidget {
  @override
  _AlojamentoFormState createState() => _AlojamentoFormState();
}

class _AlojamentoFormState extends State<AlojamentoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _bedroomTypeController = TextEditingController();
  TextEditingController _bedroomPricesController = TextEditingController();
  TextEditingController _servicesController = TextEditingController();
  TextEditingController _imagesController = TextEditingController();
  TextEditingController _promosController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

 

  List<String> _imageDescriptionList = [];
  final _picker = ImagePicker();


  
List<Uint8List> _imageBytesList = [];
List<String> _imageStringList = [];
List<File> _imageList = [];

Future<void> _getImage(ImageSource source) async {
  final pickedFile = await ImagePicker().getImage(source: source);
  if (pickedFile != null) {
    final bytes = await pickedFile.readAsBytes();
    final encodedImage = base64Encode(bytes); // Convert bytes to base64 encoded string
    setState(() {
      _imageList.add(File(pickedFile.path));
      _imageStringList.add(encodedImage); // Add encoded image string to the list
    });
  }
}


  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Descrição do alojamento"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _descriptionController,
          decoration: InputDecoration
            (
            border: OutlineInputBorder(),
            hintText: "Escreva uma descrição do alojamento",
          ),
          validator: (value) {
            if (value == "") {
              return "Escreva uma descrição do alojamento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBedroomTypeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo de quartos"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _bedroomTypeController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Indique o tipo de quartos do alojamento",
          ),
          validator: (value) {
            if (value == "") {
              return "Indique o tipo de quartos do alojamento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildBedroomPricesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Preço dos quartos"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _bedroomPricesController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Indique o preço dos quartos do alojamento",
          ),
          validator: (value) {
            if (value == "") {
              return "Indique o preço dos quartos do alojamento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildServicesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Serviços disponíveis"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _servicesController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Indique os serviços disponiveis no alojamento",
          ),
          validator: (value) {
            if (value == "") {
              return "Indique os serviços disponiveis no alojamento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildImagesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Imagens"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _imagesController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira uma imagem do alojamento",
          ),
          validator: (value) {
            if (_imageList.isEmpty && value == "") {
              return "Insira uma imagem do alojamento";
            }
            return null;
          },
          readOnly: true,
          onTap: () {
            _getImage(ImageSource.gallery);
          },
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
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Descrição da imagem",
                          ),
                          onChanged: (value) {
                            setState(() {
                              _imageDescriptionList[index] = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
      ],
    );
  }




  Widget _buildLocationInput() {
    LatLng _alojamentoLocation = LatLng(0.0, 0.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Localização exata"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira a localização do alojamento",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira a localização do alojamento";
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
        Container(
          height: 200.0,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _alojamentoLocation,
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {},
            markers: {
              Marker(
                markerId: MarkerId("alojamento_location"),
                position: _alojamentoLocation,
              ),
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromosInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Promoções"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _promosController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira as promoções disponiveis",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira as promoções disponiveis";
            }
            return null;
          },
        ),
      ],
    );
  }

  void _saveAlojamento() async {
    //retriece user's email, this we can know to who the service belongs
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "";

    if (_formKey.currentState!.validate()) {
      // List<List<int>> imageBytesList = [];
      // for (File image in _imageList) {
      //   final bytes = await image.readAsBytes();
      //   imageBytesList.add(bytes);
      // }

      List<Map<String, dynamic>> imageDescriptionList = [];
      for (String description in _imageDescriptionList) {
        imageDescriptionList.add({'description': description});
      }

      Map<String, dynamic> alojamentoData = {
        'description': _descriptionController.text,
        'bedroom_type': _bedroomTypeController.text,
        'bedroom_prices': _bedroomPricesController.text,
        'services': _servicesController.text,
        'location': _locationController.text,
        'images': _imageStringList,
        'image_descriptions': imageDescriptionList,
        'user_email': email,
      };

      String jsonBody = json.encode(alojamentoData);

      Uri url = Uri.parse('http://127.0.0.1:8000/services/alojamento');
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Se a solicitação for bem-sucedida, exiba uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Alojamento criado com sucesso!'),
        ));

        // Limpe o formulário e a lista de imagens
        _formKey.currentState!.reset();
        setState(() {
          _imageList.clear();
          _imageDescriptionList.clear();
        });
      } else {
        // Se a solicitação falhar, exiba uma mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Ocorreu um erro ao criar o alojamento.'),
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário do alojamento"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildDescriptionInput(),
              SizedBox(height: 20.0),
              _buildBedroomTypeInput(),
              SizedBox(height: 20.0),
              _buildBedroomPricesInput(),
              SizedBox(height: 20.0),
              _buildServicesInput(),
              SizedBox(height: 20.0),
              _buildImagesInput(),
              SizedBox(height: 20.0),
              _buildPromosInput(),
              SizedBox(height: 20.0),
              _buildLocationInput(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _saveAlojamento,
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
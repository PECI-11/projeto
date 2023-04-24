import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';


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

  List<File> _imageList = [];
  List<String> _imageDescriptionList = [];
  final _picker = ImagePicker();


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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
// Do something with the form data
                    print("Descriçãp: ${_descriptionController.text}");
                    print("Tipo de quartos: ${_bedroomTypeController.text}");
                    print("Preço dos quartos: ${_bedroomPricesController.text}");
                    print("Serviços: ${_servicesController.text}");
                    print("Imagens: ");
                    for (var i = 0; i < _imageList.length; i++) {
                      print("${_imageList[i].path}: ${_imageDescriptionList[i]}");
                    }
                    print("Promoções: ${_promosController.text}");
                    print("Localização: ${_locationController.text}");
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
}






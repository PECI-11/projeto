import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MonumentoForm extends StatefulWidget {
  @override
  _MonumentoFormState createState() => _MonumentoFormState();
}

class _MonumentoFormState extends State<MonumentoForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _storyController = TextEditingController();
  TextEditingController _styleController = TextEditingController();
  TextEditingController _accessabilityController = TextEditingController();
  TextEditingController _scheduleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _activityController = TextEditingController();
  TextEditingController _guideVisitController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  // List<File> _imageList = [];
  // List<String> _imageDescriptionList = [];

  // Future _getImage(ImageSource source) async {
  //   final pickedFile = await ImagePicker().getImage(source: source);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _imageList.add(File(pickedFile.path));
  //       _imageDescriptionList.add("");
  //     }
  //   });
  // }

  // Future _getPDF() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   setState(() {
  //     if (result != null) {
  //       _imageList.add(File(result.files.single.path!));
  //       _imageDescriptionList.add("");
  //     }
  //   });
  // }

  // Widget _buildStoryInput() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Text("Ementa"),
  //       SizedBox(height: 10.0),
  //       TextFormField(
  //         controller: _storyController,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(),
  //           hintText: "História do m",
  //         ),
  //         validator: (value) {
  //           if (_imageList.isEmpty && value == "") {
  //             return "Insira um arquivo PDF ou uma imagem da ementa";
  //           }
  //           return null;
  //         },
  //         readOnly: true,
  //         onTap: () {
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return SimpleDialog(
  //                 title: Text("Escolha uma opção"),
  //                 children: <Widget>[
  //                   SimpleDialogOption(
  //                     child: Text("Imagem"),
  //                     onPressed: () {
  //                       _getImage(ImageSource.gallery);
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                   SimpleDialogOption(
  //                     child: Text("PDF"),
  //                     onPressed: () {
  //                       _getPDF();
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         },
  //       ),
  //       SizedBox(height: 10.0),
  //       if (_imageList.isNotEmpty)
  //         Column(
  //           children: List.generate(_imageList.length, (index) {
  //             return Column(
  //               children: [
  //                 Image.file(_imageList[index]),
  //                 SizedBox(height: 10.0),
  //                 TextFormField(
  //                   initialValue: _imageDescriptionList[index],
  //                   decoration: InputDecoration(
  //                     border: OutlineInputBorder(),
  //                     labelText: "Descrição da imagem",
  //                   ),
  //                   onChanged: (value) {
  //                     _imageDescriptionList[index] = value;
  //                   },
  //                 ),
  //                 SizedBox(height: 10.0),
  //               ],
  //             );
  //           }),
  //         ),
  //     ],
  //   );
  // }

  Widget _buildStoryInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("História"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _storyController,
          decoration: InputDecoration
            (
            border: OutlineInputBorder(),
            hintText: "Escreva um texto sobre a história do monumento",
          ),
          validator: (value) {
            if (value == "") {
              return "Escreva um texto sobre a história do monumento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildStyleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Estilo arquitetónico"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _styleController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira o estilo arquitetónico do monumento",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira o estilo arquitetónico do monumento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAccessabilityInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Acessibilidade"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _accessabilityController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Indique se há restrições de acessibilidade",
          ),
          validator: (value) {
            if (value == "") {
              return "Indique se há restrições de acessibilidade";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildScheduleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Horário"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _scheduleController,
          decoration: InputDecoration(
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

  Widget _buildPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Preço"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _priceController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira o preçário do estabelecimento",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira o preçário do estabelecimento";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildActivityInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Atividades"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _activityController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira as atividades disponiveis",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira as atividades disponiveis";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGuideVisitInput() {
    String? _guideVisit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("É possível marcar visitas guiadas?"),
        SizedBox(height: 10.0),
        DropdownButtonFormField(
          value: _guideVisit,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "É possível marcar visitas guiadas?",
          ),
          items: [
            DropdownMenuItem(
              child: Text("Sim"),
              value: "Sim",
            ),
            DropdownMenuItem(
              child: Text("Não"),
              value: "Não",
            ),
          ],
          onChanged: (value) {
            setState(() {
              _guideVisit = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return "Selecione uma opção";
            }
            return null;
          },
        ),
      ],
    );
  }


  Widget _buildLocationInput() {
    LatLng _monumentLocation = LatLng(0.0, 0.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Localização exata"),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _locationController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Insira a localização do monumento",
          ),
          validator: (value) {
            if (value == "") {
              return "Insira a localização do monumento";
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
        Container(
          height: 200.0,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _monumentLocation,
              zoom: 15.0,
            ),
            onMapCreated: (GoogleMapController controller) {},
            markers: {
              Marker(
                markerId: MarkerId("monument_location"),
                position: _monumentLocation,
              ),
            },
          ),
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
              _buildStoryInput(),
              SizedBox(height: 20.0),
              _buildStyleInput(),
              SizedBox(height: 20.0),
              _buildAccessabilityInput(),
              SizedBox(height: 20.0),
              _buildScheduleInput(),
              SizedBox(height: 20.0),
              _buildPriceInput(),
              SizedBox(height: 20.0),
              _buildActivityInput(),
              SizedBox(height: 20.0),
              _buildGuideVisitInput(),
              SizedBox(height: 20.0),
              _buildLocationInput(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
// Do something with the form data
                    print("História: ${_storyController.text}");
                    print("Estilo: ${_styleController.text}");
                    print("Acessibilidade: ${_accessabilityController.text}");
                    print("Horário: ${_scheduleController.text}");
                    print("Preços: ${_priceController.text}");
                    print("Atividade: ${_activityController.text}");
                    print("Visitas guiadas: ${_guideVisitController.text}");
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






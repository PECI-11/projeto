import 'package:flutter/material.dart';
import 'package:ssd_frontend/servicos/cartao_servico.dart';
import '../componentes/section_title.dart';
import '../modelos/exemplos_servicos.dart';

class ServicosDisponiveis extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1110),
      child: Column(
        children: [
          SectionTitle(
            color: Color(0xFFFF0000),
            title: "Serviços Disponíveis",
            subtitle: "", key: null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                servicos.length, (index) => CartaoServicos(index: index, key: null,)),
          )
        ],
      ),
    );
  }
}
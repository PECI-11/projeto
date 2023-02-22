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
            title: "Serviços Disponíveis",
            subtitle: "",
            color: Color(0xFFFF0000),
            key: ValueKey(1)  // VERIFICAR MELHOR ISTO 
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
                servicos.length, (index) => CartaoServicos(index: index, key: ValueKey(1),)), // VERIFICAR MELHOR ISTO
          )
        ],
      ),
    );
  }
}
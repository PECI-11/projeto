import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class SideNavigation extends StatefulWidget {
  const SideNavigation({Key? key}) : super(key: key);

  @override
  _SideNavigationState createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {

  List<Widget> views = const[
    Center(
      child: Text('Perfil'),
    ),
    Center(
      child: Text('Anúncios das Ofertas'),
    ),
    Center(
      child: Text('Notícias'),
    ),
    Center(
      child: Text('Serviços disponíveis'),
    ),
    Center(
      child: Text('Terminar sessão'),
    ),
  ];

  // The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Row(
        children: [
          SideNavigationBar(
              selectedIndex: selectedIndex,
              items: const[
                SideNavigationBarItem(
                    icon: Icons.person,
                    label: 'Perfil'
                ),

                SideNavigationBarItem(
                    icon: Icons.dashboard,
                    label: 'Anúncios das Ofertas'
                ),

                SideNavigationBarItem(
                    icon: Icons.chat_rounded,
                    label: 'Notícias'
                ),

                SideNavigationBarItem(
                    icon: Icons.dataset_rounded,
                    label: 'Serviços disponíveis'
                ),

                SideNavigationBarItem(
                    icon: Icons.logout_rounded,
                    label: 'Terminar sessão'
                ),

              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              }
          ),
          Expanded(
              child: views.elementAt(selectedIndex),
          ),
        ],
      ),
    );
  }


}


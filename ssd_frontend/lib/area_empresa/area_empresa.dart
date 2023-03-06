import 'package:flutter/material.dart';
import 'perfil_empresa.dart';

class AreaEmpresa extends StatefulWidget {
  const AreaEmpresa({Key? key}) : super(key: key);

  @override
  State<AreaEmpresa> createState() => _AreaEmpresaState();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Perfil',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Anúncios das Ofertas',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.chat_rounded),
    activeIcon: Icon(Icons.chat_rounded),
    label: 'Notícias',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.dataset_rounded),
    activeIcon: Icon(Icons.dataset_rounded),
    label: 'Serviços Disponíveis',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.logout_rounded),
    activeIcon: Icon(Icons.logout_rounded),
    label: 'Terminar sessão',
  ),
];

List<Widget> _widgetOptions = <Widget> [
  Container(
    child: ProfilePageCompany(),
  ),

  Container(

  ),
];

class _AreaEmpresaState extends State<AreaEmpresa> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Área da Empresa'),
      ),

      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
          items: _navBarItems,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          })
          : null,
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: isLargeScreen,
              destinations: _navBarItems
                  .map((item) => NavigationRailDestination(
                  icon: item.icon,
                  selectedIcon: item.activeIcon,
                  label: Text(
                    item.label!,
                  )
                )
              ).toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text("${_navBarItems[_selectedIndex].label} Page"),
            ),
          )
        ],
      ),
    );
  }
}

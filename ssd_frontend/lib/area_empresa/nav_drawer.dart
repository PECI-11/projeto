import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ssd_frontend/modelos/nav_item.dart';
import 'package:ssd_frontend/provider/nav_provider.dart';

import '../users/user1.dart';

class NavigationDrawerWidget extends StatelessWidget {

  static final padding = EdgeInsets.symmetric(horizontal: 20);


  @override
  Widget build(BuildContext context) => Drawer(
    child: Container(
      color: Color.fromRGBO(50, 55, 205, 1),
      child: ListView(
        children: [
          buildHeader(
            context,
            urlImage: urlImage,
            name: name,
            email: email,
          ),
          Container(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  item: NavigationItem.perfil,
                  text: 'Perfil',
                  icon: Icons.person,
                ),

                buildMenuItem(
                  context,
                  item: NavigationItem.ofertas,
                  text: 'Anúncios das Ofertas',
                  icon: Icons.dashboard_rounded,
                ),

                buildMenuItem(
                  context,
                  item: NavigationItem.noticias,
                  text: 'Notícias',
                  icon: Icons.comment,
                ),

                buildMenuItem(
                  context,
                  item: NavigationItem.servicos,
                  text: 'Serviços Disponíveis',
                  icon: Icons.dataset_rounded,
                ),

                buildMenuItem(
                  context,
                  item: NavigationItem.logout,
                  text: 'Terminar sessão',
                  icon: Icons.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildMenuItem (
      BuildContext context, {
        required NavigationItem item,
        required String text,
        required IconData icon,
      }) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final color = isSelected ? Colors.orangeAccent : Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
        onTap: () => selectItem(context, item),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }


  Widget buildHeader(
      BuildContext context, {
        required String urlImage,
        required String name,
        required String email,
      }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => selectItem(context, NavigationItem.perfil),
          child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                  child: Icon(Icons.add_comment_outlined, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      );

}

